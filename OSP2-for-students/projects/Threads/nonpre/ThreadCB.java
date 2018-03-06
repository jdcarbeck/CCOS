package osp.Threads;
import java.util.Vector;
import java.util.Enumeration;
import osp.Utilities.*;
import osp.IFLModules.*;
import osp.Tasks.*;
import osp.EventEngine.*;
import osp.Hardware.*;
import osp.Devices.*;
import osp.Memory.*;
import osp.Resources.*;

public class ThreadCB extends IflThreadCB {
  private staic GenericList readyQueue;

  public ThreadCB() {
    super();
  }

  public static void init() [
    readyQueue = new GenericList(); 
  }

  //Create a thread and places it on the queue
  static public ThreadCB do_create(TaskCB task) {
    if(task == null) {
      dispatch();
      return null;
    }
    
    if (task.getThreadCount() >= MaxThreadsPerTask) {
      MyOut.print("osp.Threads.ThreadCB", "Failed to create new thread " +
                  " -- maximum number if threads for " + task + "reached");
      dispatch();
      return null;
    }

    ThreadCB newThread = new ThreadCB();
    MyOut.print("osp.Threads.ThreadCB", "Created " + newThread);

    newThread.setPriority(task.getPriority());
    newThread.setStatus(ThreadReady);
    newThread.setTask(task);

    if(task.addThread(newThread) != SUCCESS) {
      MyOut.print("osp.Threads.ThreadCB", 
                  "Could not add thread "+ newThread +"to task"+ task);
      dispatch();
      return null;
    }

    readQueue.append(newThread);
    MyOut.print("osp.Threads.ThreadCB",
                "successfully added "+ newThread +" to "+ task);
    dispatch();
    return newThread;
  }

  public void do_kill() {
    MyOut.print(this, "Entering do_kill("+this+")");
    TaskCB task = getTask();
    switch(getStatus()) {
      case ThreadReady:
          readQueue.remove(this);
          break;
      case ThreadRunning:
          if(this == MMU.getPTBR().getTask().getCurrentThread())
            MMU.getPTBR().getTask().setCurrentThread(null);
          break;
      default:
          break;
    }

    if(task.removeThread(this) != SUCCESS) {
      MyOut.print(this, "Could not remove thread"+this+"from task"+task);
      return;
    }

    MyOut.print(this, this+" is set to be destroyed");

    setStatus(ThreadKill);

    for(int i=0; i < Device.getTableSize(); i++) {
      MyOut.print(this, "Purging IORBs on Device "+i);
      Device.get(i).cancelPendingIO(this);
    }

    ResourceCB.giveupResources(this);
    dispatch();

    if(this.getTask().getThreadCount()==0) {
      MyOut.print(this, "Destroying "+this+": "+this.getTask() +
                        " leaves no threads left; destroying the task");
      this.getTask().kill();
    }
  }
  
  public void do_suspend(Event event) {
    int oldStatus = this.getStatus();
    MyOut.print(this, "Entering suspend("+this+","+event+")");

    Thread runningThread=null;
    TaskCB runningTask=null;
    try {
      runningTask=MMU.getPTBR().getTask();
      runningThread = runningTask.getCurrentThread();
    } catch(NullPointerException e){}

    //check if this is the running thread
    if(this == runningThread)
      this.getTask().setCurrentThread(null);
    
    //Set status
    if(this.getStatus() == ThreadRunning)
      setStatus(ThreadWaiting);
    else if (this.getStatus() >= ThreadWaiting)
      setStatus(this.getStatus()+1);

    readyQueue.remove(this);
    event.addThread(this);

    dispatch();
  }

  public void do_resume() {
    if(getStatus() < ThreadWaiting) {
      MyOut.print(this, "Attempt to resume "+this+
                        ", which wasn't waiting");
      return;
    }
    
    MyOut.print(this, "Resuming "+this);
    
    //set thread status
    if(getStatus()==ThreadWaiting)
      setStatus(ThreadReady);
    else if (getStatus() > ThreadWaiting)
      setStatus(getStatus - 1);
    
    //Put thread on queue if appropriate
    if(getStatus()==ThreadReady)
      readyQueue.append(this);
    dispatch();
  }

  public static int do_dispatch() {
    ThreadCB threadToDispatch=null;
    ThreadCB runningThread=null;
    TaskCB runningTask=null;

    try {
      runningTask = MMU.getPTBR().getTasj();
      runningThread = runningTask.getCurrentThread();
    } catch(NullPointerException e) {}

    //If necessary remove current thread an reschedule it
    if(runningThread != null) {
      MyOut.print("osp.Threads.ThreadCB", 
                  "Oreentubg cyrrebtky rybbubg " + runningThread);

      runningTask.setCurrentThread(null);
      MMU.setPTBR(null);

      runningThread.setStatus(ThreadReady);
      readyQueue.append(runningThread);
    }

    //Select thread from ready queue
    threadToDispatch = (ThreadCB)readyQueue.removeHead();
    if(threadToDispatch == null) {
      MyOut.print("osp.Threads.ThreadCB",
                  "Can't find suitable thread to dispatch");
      MMU.setPTBR(null);
      return FAILURE;
    }

    //put thread on processor.
    MMU.setPTBR(threadToDispatch.getTask.getPageTable());

    //set thread to dispatch as the current thread of its task
    threadToDispatch.getTask().setCurrentTread(threadToDispatch);

    //set Thread's status.
    threadToDispatch.setStatus(ThreadRunning);

    MyOut.print("osp.Threads.ThreadCB",
                "Dispatching " + threadToDispatch);

    HTimer.set(150);
  
    return SUCCESS;
  }

  public static void atError() {}

  public static void atWaring() {}
}

byte n = 0;
byte p_complete = 0;

proctype P() {
  byte temp = 0;
  byte p_count = 0;
  do :: p_count == 2 -> break
     :: else ->
        temp = n;
        temp++;
        n = temp;
        p_count++ 
  od;
  p_complete++;
}

proctype Q() {
  byte q_count = 0;
  do :: q_count == 2 -> break
     :: else ->
        n++;
        q_count++
  od;
  p_complete++;
}

init {
  run P();
  run Q();
  p_complete == 2;
  assert(n == 4);
}

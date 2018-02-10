#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>

typedef struct
{
   char* string;
   pthread_mutex_t mutex;
   pthread_cond_t cond;
   pthread_cond_t cond_p;
   pthread_t touched_by;
   int value_needs_printing;
   int finished;
} data_t;


void* consumer_thread(void* arg) 
{
    data_t* data_ptr = (void*)arg;
    while(!data_ptr->finished)
    {
        pthread_mutex_lock(&data_ptr->mutex);
        if(!data_ptr->value_needs_printing)
            pthread_cond_wait(&data_ptr->cond, &data_ptr->mutex);   
        data_ptr->touched_by = pthread_self();
        pthread_cond_signal(&data_ptr->cond_p);
        pthread_mutex_unlock(&data_ptr->mutex);
    }
    pthread_exit(0);
}

void* producer_thread(void* arg) 
{
    data_t* data_ptr = (void*)arg;
    while(!data_ptr->finished)
    {
        pthread_mutex_lock(&data_ptr->mutex);
        if(!data_ptr->value_needs_printing)
            pthread_cond_wait(&data_ptr->cond_p, &data_ptr->mutex);
        int thread_id = (int)data_ptr->touched_by;
        printf("%u thread handled: %s", thread_id, data_ptr->string);
        fflush(stdin);
        data_ptr->value_needs_printing = 0;
        pthread_mutex_unlock(&data_ptr->mutex);
    }
    pthread_exit(0);
}

int main(int argc, char** argv) 
{
    data_t input_data;
    input_data.finished =0;
    input_data.value_needs_printing =0;

    pthread_mutex_init(&input_data.mutex, NULL);
    pthread_cond_init(&input_data.cond, NULL);
    pthread_cond_init(&input_data.cond_p,NULL);
    
    pthread_t consum_th[3];
    pthread_t produc_th;

    size_t consum_th_size = sizeof(consum_th)/sizeof(pthread_t);
    for(int i = 0; i < consum_th_size; i++)
        pthread_create(&consum_th[i], NULL, consumer_thread, (void *)&input_data);
    pthread_create(&produc_th, NULL, producer_thread, (void *)&input_data);

    int finished = 0;
    while(!finished) 
    {
        char* buffer;
        size_t bufsize = 100;
        buffer = (char*)malloc(bufsize * sizeof(char));
        getline(&buffer, &bufsize, stdin);
        if(strcmp("exit\n", buffer) == 0)
        {
            pthread_mutex_lock(&input_data.mutex);
            input_data.finished = 1;
            pthread_cond_broadcast(&input_data.cond);
            pthread_cond_signal(&input_data.cond_p);
            pthread_mutex_unlock(&input_data.mutex);
            finished = 1;
        }
        else if(strcmp("\n", buffer) != 0)
        {
            pthread_mutex_lock(&input_data.mutex);
            input_data.string = buffer;
            input_data.value_needs_printing = 1;
            pthread_cond_signal(&input_data.cond);
            pthread_mutex_unlock(&input_data.mutex);
        }
        free(buffer);    
    }

    for(int i = 0; i < consum_th_size; i++)
        pthread_join(consum_th[i], NULL);
    pthread_join(produc_th,NULL);

    return 0;
}

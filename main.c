#include <stdlib.h>
#include <stdio.h>

void printIntArray(int arr[], int tam);
void bubbleSort(int array[], int n);
void insertionSort(int array[], int tam);
void selectionSort(int array[], int tam);

void main(){
    int arrayTeste[10] = {5, 6, 2, 3, 4, 7, 9, 10, 1, 8};
    selectionSort(arrayTeste, 10);
    printIntArray(arrayTeste,10);
}
void printIntArray(int arr[], int tam){
    for (int i = 0; i < tam-1; i++) printf("%d, ", arr[i]);
    printf("%d\n", arr[tam-1]);
}
void swap(int* a, int* b){
    int temp = *a;
    *a = *b;
    *b = temp;
}
void bubbleSort(int array[], int tam){
    int temp;
    int trocado = 0;
    for (int i = 0; i < tam - 1; i++){
        for (int j = 0; j < tam - i - 1; j++){
            if(array[j] > array[j + 1]){
                swap(&array[j], &array[j + 1]);
                trocado = 1;
            }
        }

        if(!trocado){
            break;
        }
    }
}
void insertionSort(int array[], int tam){
    int i,j, eleito;
    for(i = 1; i<tam; i++){
        eleito = array[i];
        j = i-1;
        while(j>=0 && eleito<array[j]){
            array[j+1] = array[j];
            j-=1;
        }
        array[j+1]=eleito;
    }
}
void selectionSort(int array[], int tam){
    int i,j, idMenor;
    for(i=0; i<tam-1;i++){
        idMenor = i;
        for(j = i+1; j < tam; j++){
            if(array[j]<array[idMenor]){
                idMenor=j;
            }
        }
        if(i != idMenor){
            swap(&array[i],&array[idMenor]);
        }
    }
}
#include <stdio.h>
#include <stdlib.h>

/// easier input validation.
int getprompt(char prompt[]) {
        int temp_input;
        while(1) 
        {
            printf(prompt);
            scanf("%d", &temp_input);
            if (temp_input >= 0) break;
        }
        return temp_input;
    }

/// The recursive function
int the_recursive(int black_box,int gray_box, int white_box, int the_n)
{
 if(the_n == 0) return black_box;
 return the_recursive(gray_box, white_box, (black_box + gray_box + white_box), (the_n - 1));
}


int main() {
    /// stuff we just want the same as our asm file so it is easier to handle.
    char prompt0[] = "Enter tribonacci(0): ";
    char prompt1[] = "Enter tribonacci(1): ";
    char prompt2[] = "Enter tribonacci(2): ";
    char promptN[] = "Enter n: ";
    /// okay the end output is different.
    char result[] = "tribonacci(%d) = %d";
    /// input
    int input0 = getprompt(prompt0);
    int input1 = getprompt(prompt1);
    int input2 = getprompt(prompt2);
    int inputN = getprompt(promptN);

    /// work
    /* Should be easier because we are shifting the  */ 
    int the_end;
    the_end = the_recursive(input0,input1,input2,inputN);

    /// output
    printf(result,inputN,the_end);
}
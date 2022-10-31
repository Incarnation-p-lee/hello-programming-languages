#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    FILE *fp = tmpfile();
    int fd = fileno(fp);

    printf("Try to write to tmp file with fd %d ...\n", fd);

    fprintf(fp, "Hello, the C programming language with linux!\n");

    printf("Try to sleep 3 seconds\n");

    sleep(3);
    fclose(fp);

    printf("Completed!\n");

    return EXIT_SUCCESS;
}

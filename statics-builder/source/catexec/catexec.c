/* ugly hack, but works

   Output a file to another process started by this tool
   Usage:

   catexec SOURCEPATH BINPATH [arg...]

   (c) 2020 Michael Keller, minesworld.de
*/

#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/wait.h>
#include <sys/types.h>

int main(int argc, char *argv[]) {
    if (argc < 3) {
        return 1;
    }

    pid_t child_pid;
    if ((child_pid = fork()) < 0) {

        perror("fork() error");
        return errno;
    
    } else if (child_pid == 0) {

        FILE *fileout;
        if ((fileout = fopen(argv[1], "rb")) == NULL) {
            perror("fopen() error");
            return errno;
        }

        dup2(fileno(fileout), STDIN_FILENO);
        fclose(fileout);

        execvp(argv[2], &argv[2]);
        return errno;

    }
    
    int status;
    wait(&status);

    return 0;
}
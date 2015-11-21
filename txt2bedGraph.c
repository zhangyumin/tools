#include<stdio.h>
#include<stdlib.h>
void main()
{
	FILE *fp,*fd,*ft;
	if((fp=fopen("./tojbrowse/pat.txt","r"))==NULL)
	{
		printf("can't open txt files\n");
		exit(0);
	}
	if((fd=fopen("./tojbrowse/Uppat.bedGraph","w"))==NULL)
	{
		printf("can't open PAT1 files\n");
		exit(0);
	}
	if((ft=fopen("./tojbrowse/Unpat.bedGraph","w"))==NULL)
	{
		printf("can't open PAT2 files\n");
		exit(0);
	}
	//char buffer[100];
	int coord,tagNum=0;
	char Chr[10],strand[10];
	while(!feof(fp))
	{
		
		fscanf(fp,"%s\t%s\t%d\t%d\n",Chr,strand,&coord,&tagNum);
		//printf("%s\t%d\t%d\t%d\n",Chr,coord,coord+1,tagNum);
		if(strand[0]=='+')
			fprintf(fd,"%s\t%d\t%d\t%d\n",Chr,coord,coord+1,tagNum);
		if(strand[0]=='-')
			fprintf(ft,"%s\t%d\t%d\t%d\n",Chr,coord,coord+1,-tagNum);
	}
	printf("work done!\n");
	fclose(fp);
	fclose(fd);
}

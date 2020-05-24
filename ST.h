struct fsym
{
	char* name;
	int val;
	struct fsym *next;
};
typedef struct fsym fsym;

fsym *start=NULL;

void fsym_put(char* a, int b){
	struct fsym *ptr,*temp;
	temp=(fsym *)malloc(sizeof(fsym));
	temp->name=(char *)malloc(strlen(a)+1);
	strcpy(temp->name,a);
	temp->val=b;
	if(start==NULL){
		start=temp;
	}
	else{
		ptr=start;
		while(ptr->next!=NULL){
			ptr=ptr->next;
		}
		ptr->next=temp;
	}
}

void fsym_get(char* a){
	fsym *ptr;
	ptr=start;
	while((strcmp(ptr->name,a))){
		ptr=ptr->next;
	}
	printf("%d\n",ptr->val);
}


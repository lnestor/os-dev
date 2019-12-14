int foo()
{
  return 1;
}

int main()
{
  char *video_mem = (char*) 0xb8000;
  *video_mem = 'X';
  *(video_mem + 2) = 'X';
  *(video_mem + 6) = 'X';
}

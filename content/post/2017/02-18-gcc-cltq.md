---
title: "Mysterious cltq x86 instruction"
author: "Ramon Dev"
date: "2017-02-18T23:10:20Z"
draft: false
output: #html_document
  blogdown::html_page:
    highlight: pygments
params:
  theme: solarized-dark
categories: [ "info" ]
tags: [ "gcc", "c", "asm", "cltq", "bug" ]
---


Today I was working on some ugly C code and faced a strange issue:<br>
a returned value by a function was different when we are back to the caller.
<br>
And no, it's not a gcc bug ;)<br>
Let's talk about that !<br>
<br>
create 2 files, file1.c and file2.c like this.
File1.c:<br>


<pre><code class="C">
#include < stdio.h>

int main(int argc, char* argv[])
{
	void* p = (void*)test_return();
	printf("p = %p\n", p);
	return 0;
}
</code></pre>

file2.c:<br>

<pre><code class="C">
#include < stdio.h>

void* test_return()
{
	void* p = (void*)0x7fb380fd2e20;
	printf("p = %p\n", p);
	return p;
}
</code></pre>

compile the code:<br>

<pre><code class="Bash">
gcc -o test file1.c file2.c
</code></pre>

Now, run the binary:<br>

<pre><code class="Bash">
[phaxos@orion]~/tmp2/buggcc% ./test 
p = 0x7fb380fd2e20
p = 0xffffffff80fd2e20
</code></pre>


Yes, the value has changed.<br>
So what is going on ?<br>
Look to the gcc warning when compiling:<br>

<pre><code class="Bash">
file1.c: In function ‘main’:
file1.c:7:19: warning: implicit declaration of function ‘test_return’ [-Wimplicit-function-declaration]
  void* p = (void*)test_return();
                   ^~~~~~~~~~~
file1.c:7:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  void* p = (void*)test_return();
            ^
</code></pre>

Now, let's check the assembler code:<br>

<pre><code class="Intel x86 Assembly">
0000000000400526 < main >:
  400526:	55                   	push   %rbp
  400527:	48 89 e5             	mov    %rsp,%rbp
  40052a:	48 83 ec 20          	sub    $0x20,%rsp
  40052e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  400531:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  400535:	b8 00 00 00 00       	mov    $0x0,%eax
  40053a:	e8 23 00 00 00       	callq  400562 <test_return>
  40053f:	48 98                	cltq   
  400541:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  400545:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400549:	48 89 c6             	mov    %rax,%rsi
  40054c:	bf 30 06 40 00       	mov    $0x400630,%edi
  400551:	b8 00 00 00 00       	mov    $0x0,%eax
  400556:	e8 a5 fe ff ff       	callq  400400 <printf@plt>
  40055b:	b8 00 00 00 00       	mov    $0x0,%eax
  400560:	c9                   	leaveq 
  400561:	c3                   	retq   

0000000000400562 < test_return >:
  400562:	55                   	push   %rbp
  400563:	48 89 e5             	mov    %rsp,%rbp
  400566:	48 83 ec 10          	sub    $0x10,%rsp
  40056a:	48 b8 20 2e fd 80 b3 	movabs $0x7fb380fd2e20,%rax
  400571:	7f 00 00 
  400574:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  400578:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  40057c:	48 89 c6             	mov    %rax,%rsi
  40057f:	bf 38 06 40 00       	mov    $0x400638,%edi
  400584:	b8 00 00 00 00       	mov    $0x0,%eax
  400589:	e8 72 fe ff ff       	callq  400400 <printf@plt>
  40058e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400592:	c9                   	leaveq 
  400593:	c3                   	retq   
  400594:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40059b:	00 00 00 
  40059e:	66 90                	xchg   %ax,%ax
</code></pre>

what is this cltq instruction ?<br>
The datasheet say "R[%rax] <- SignExtend(R[%eax])  - Convert %eax to quad
word"<br>


So gcc think that this function test_return is returning a 32 bytes value, **and
then convert it into 64 bytes variable**.<br>
Why does gcc think that ? Because in my computer, for my gcc sizeof(int) = 4 and not 8.<br>
So, because we dont provide the prototype of test_return function, it thinks
it's retuning a 32 bits value.<br>
**So the solution is just to declare the prototype ;)**<br>
That's why I hate to work on dirty code ... 


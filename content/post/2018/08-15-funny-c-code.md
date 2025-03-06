---
date: "2018-08-15T20:53:25Z"
author: "Ramon Dev"
title: "Funny C code"
draft: false
output: #html_document
  blogdown::html_page:
    highlight: pygments
params:
  theme: solarized-dark
categories: [ "info" ]
tags: [ "c" ]
---

Here is something funny about C langage :)<br>
Watch carefuly this function below and try to guess what will this program print to the console.

<pre><code class="c">
#include < stdio.h >

int main(void)
{
    int p[] = {0, 1, 2, 3, 4, 5, 6, 7};
    int i=3;

    printf("i[%d]=%d\n", i, i[p]);
    return 0;
}
</code></pre>

Is this code correct ? If the answer is yes, then what doest printf print ?<br>
Well ... the answer is easy ...
<pre><code class="C">
i[p] = *(i + p) = *(p + i) = p[i] = 3;
</code></pre>


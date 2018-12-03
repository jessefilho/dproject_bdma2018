#!/usr/bin/python
#python -m pip install Bing plaintext parsetree search Graph
import sys; sys.path.append('C:\Python27amd64\Lib\pattern')
from pattern   import Bing, plaintext
from pattern     import parsetree
from pattern import search
from pattern  import Graph
 
g = Graph()
for i in range(10):
    for result in Bing().search('"more important than"', start=i+1, count=50):
        s = r.text.lower() 
        s = plaintext(s)
        s = parsetree(s)
        p = '{NP} (VP) more important than {NP}'
        for m in search(p, s):
            x = m.group(1).string # NP left
            y = m.group(2).string # NP right
            if x not in g:
                g.add_node(x)
            if y not in g:
                g.add_node(y)
            g.add_edge(g[x], g[y], stroke=(0,0,0,0.75)) # R,G,B,A
 
g = g.split()[0] # Largest subgraph.
 
for n in g.sorted()[:40]: # Sort by Node.weight.
    n.fill = (0, 0.5, 1, 0.75 * n.weight)
 
g.export('test', directed=True, weighted=0.6)
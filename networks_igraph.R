###############################################################
###############################################################
####
####            PART I: NETWORKS
####
###############################################################
###############################################################
## source: https://assemblingnetwork.wordpress.com/2013/05/29/network-basics-with-r-and-igraph-part-i-of-iii/
# the igraph library is good for network based analyses
library(igraph)

# First lets build a network using basic formulas:

graph.onelink<-graph.formula(A-+B)

# This gives us a two species network (A and B) with one link (represented by A-+B). With this function the (+) sign signifies the "arrowhead".
# We can visualize our simple 2 species network with plot.igraph().

plot.igraph(graph.onelink)

# Using graph.formula() we can create any graph we want, as long as we are willing to write out every interaction by hand. Here is another simple example, a four species food chain:

graph.foodchain<-graph.formula(A-+C,B-+C,C-+D)

# and plot it:

plot.igraph(graph.foodchain)
#A and B are eaten by C while D eats C

#igraph has a function for generating random networks of varying size and connectance.

graph.random.gnp<-erdos.renyi.game(n=20,p.or.m=.5,type="gnp",directed=T)
plot.igraph(graph.random.gnp)

# We can also change the layout of the graph, here we will plot the nodes in a circle
plot.igraph(graph.random.gnp,layout=layout.circle)

# Here we have created a random directed graph with 20 species ("n") and a connectance ("p") of 0.5 (that is any two nodes have a 50% probability of being connected).
# By setting "type='gnp'" we tell the function to assign links with the probability "p" that we specify.
# Similarly we can set the number of links that we want in the system to a value "m" that we specify.

graph.random.gnm<-erdos.renyi.game(n=20,p.or.m=100,type="gnm",directed=T)
plot.igraph(graph.random.gnm)

# Here the number of links in the network is set to 100, and they are assigned uniformly randomly

# Rather than being truly random, many real networks exhibit some type of organization. Of particular note is the prevalance of scale-free networks. A scale free network is one whose degree distribution is such that a majority of nodes have relatively few links, while few nodes have many links (following a power law).
# To model scale free networks Barabasi and Albert developed the preferential attachment model in 1999. In this model new nodes are more likely to link to nodes with a higher number of links.

# In igraph we can use the barabasi.game() function:
graph.barabasi.1<-barabasi.game(n=50,power=1)

# For this graph I will introduce some new plotting tools to specify layout and vertex/edge properties.

plot.igraph(graph.barabasi.1,
            layout=layout.fruchterman.reingold,
            vertex.size=10,         # sets size of the vertex, default is 15
            vertex.label.cex=.5,    # size of the vertex label
            edge.arrow.size=.5        # sets size of the arrow at the end of the edge
)

# there are a number of different plotting parameters see
#?igraph.plotting
#for details

plot.igraph(graph.barabasi.1,
            layout=layout.fruchterman.reingold,
            vertex.size=10,
            vertex.label.cex=.5,
            edge.arrow.size=.5,
            mark.groups=list(c(1,7,4,13,10,16,15,41,42,29),
                             c(2,48,5,36,43,33,9)), # draws polygon around nodes
            mark.col=c("green","blue")
)
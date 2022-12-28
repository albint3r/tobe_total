# How this works?

The training creator is conformed by layers. These layers are:

- Training week
- WOD
- Blocks
- Movements selector or fill blocks

Each parent determinate what would have their child. For example, the training week dictates what is going to
be inside the WODs. At the same way, the WOD it would dictate what is inside each block. And lastly
the Blocks dictates what movements are inside. 

Each piece of the program is independent and only return some information, that the child would use to create their
data part and so on. 
# Ausführen auf: http://blog.trinket.io/interactive-python-tools/
# auch sehenswert: http://www.skulpt.org/
# ebenso: http://85.214.246.147:8080/home/pub/201/
# schließlich: http://nbviewer.ipython.org/urls/bitbucket.org/ipre/calico/raw/master/notebooks/Python/GraphicsSVG.ipynb
import turtle

tommy = turtle.Turtle()
tommy.shape("turtle")
tommy.speed(0)

def koch(turtle, size):
    if size <= 10:
        turtle.forward(size)
    elsizee:
        koch(turtle, size/3)
        turtle.left(60)
        koch(turtle, size/3)
        turtle.right(120)
        koch(turtle, size/3)
        turtle.left(60)
        koch(turtle, size/3)

koch(tommy, 100)

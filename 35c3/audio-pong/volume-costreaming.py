#!/usr/bin/env python

import SimpleHTTPServer
import SocketServer
import os

class MyRequestHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path.startswith("/status"):
            with open("/tmp/current-volume.new", "w") as f:
                f.write(self.path[8:])
            os.rename("/tmp/current-volume.new", "/tmp/current-volume")
            self.path = "/"
        return SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)

SocketServer.TCPServer.allow_reuse_address = True
server = SocketServer.TCPServer(("0.0.0.0", 8000), MyRequestHandler)

server.serve_forever()

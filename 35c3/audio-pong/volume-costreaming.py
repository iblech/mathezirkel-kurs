#!/usr/bin/env python

import http.server
import socketserver
import os

class MyRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path.startswith("/status"):
            with open("/tmp/current-volume.new", "w") as f:
                f.write(self.path[8:])
            os.rename("/tmp/current-volume.new", "/tmp/current-volume")
            self.path = "/"
        return http.server.SimpleHTTPRequestHandler.do_GET(self)

socketserver.TCPServer.allow_reuse_address = True
server = socketserver.TCPServer(("0.0.0.0", 8000), MyRequestHandler)

server.serve_forever()

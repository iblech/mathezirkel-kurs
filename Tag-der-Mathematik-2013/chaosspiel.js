function multiTo(ctx, points) {
  if(points.length == 0) return;
  ctx.moveTo(points[0][0], points[0][1]);
  for(var i = 1; i < points.length; i++) {
    ctx.lineTo(points[i][0], points[i][1]);
  }
}

function randomConvexComb(points) {
  var x = 0, y = 0;
  var sum = 0;
  for(var i = 0; i < points.length; i++) {
    var lambda = Math.random();
    x   = x + lambda * points[i][0];
    y   = y + lambda * points[i][1];
    sum = sum + lambda;
  }
  return [x / sum, y / sum];
}

function drawDot(ctx, x,y, radius, color) {
  ctx.fillStyle = color;
  ctx.beginPath();
  ctx.arc(x, y, radius, 0, 2*Math.PI, true);
  ctx.fill();
}

function doReset(ctx) {
  ctx.fillStyle = "lightblue";
  ctx.strokeStyle = "darkblue";

  ctx.clearRect(0,0, xmax, ymax);

  ctx.beginPath();
  multiTo(ctx, vertices);
  ctx.fill();

  ctx.beginPath();
  multiTo(ctx, vertices);
  ctx.closePath();
  ctx.stroke();
}

function doStep(ctx, r, v, j) {
  var c = ["red", "green", "blue", "yellow"][j];

  var q = [ 0.5*r[0] + 0.5*v[0], 0.5*r[1] + 0.5*v[1] ];
  drawDot(ctx, q[0], q[1], ptRadius, c);
  
  ctx.beginPath();
  ctx.moveTo(r[0], r[1]);
  ctx.lineTo(q[0], q[1]);
  ctx.lineWidth = 0.3;
  ctx.stroke();
  ctx.lineWidth = 4;

  return q;
}

function doFullGame(ctx, numIter) {
  var r = randomConvexComb(vertices);

  ctx.fillStyle = "darkblue";
  drawDot(ctx, r[0], r[1], ptRadius, colorHilight);

  for(var i = 0; i < numIter - 1; i++) {
    var j = Math.floor(Math.random() * vertices.length);
    var p = vertices[j];

    r = doStep(ctx, r, p, j);
  }
}

var xmax = 1000, ymax = 1000;
var ptRadius = 4;
var colorNormal = "darkblue";
var colorHilight = "yellow";

var vertices = [ [ xmax/2, 0 ], [ xmax, ymax ], [ 0, ymax ] ];
//var vertices = [ [ 0, 0 ], [ xmax, 0 ], [ xmax, ymax ], [0, ymax] ];

var canvas = document.getElementById('canvas');
canvas.setAttribute('width', xmax);
canvas.setAttribute('height', ymax);
var ctx = canvas.getContext('2d');
ctx.lineWidth = 4;

doReset(ctx);

globalR = randomConvexComb(vertices);

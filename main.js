/**
 *  Main JS
 */
function shit() {

  var player = new jaws.Rect(50, 50, 50, 50);
  var speed = 2;

  this.update = function() {
    if (jaws.pressed("a")) {player.move(-speed, 0)};
    if (jaws.pressed("d")) {player.move(speed, 0)};
    if (jaws.pressed("s")) {player.move(0, speed)};
    if (jaws.pressed("w")) {player.move(0, -speed)};
    if (jaws.pressed("up") && speed < 10) {speed++};
    if (jaws.pressed("down") && speed > 1) {speed--};
  }

  this.draw = function() {
    jaws.clear();
    player.draw();
  }

}


window.onload = function() {
  jaws.start(shit);
}
var c = document.getElementById("canvas");
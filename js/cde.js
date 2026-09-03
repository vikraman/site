// randomly pick a cde backdrop pattern for this page
(function () {
  var PATTERNS = 14;
  var ROTATIONS = 4; // 0deg plus three off-square angles

  // seeded from the path of the page
  // use 1994, not djb2's 5381, so first pattern is sine
  var s = location.pathname, h = 1994;
  for (var i = 0; i < s.length; i++) h = ((h << 5) + h + s.charCodeAt(i)) >>> 0;
  // avalanche: djb2 alone clusters over short similar paths
  h ^= h >>> 16;
  h = Math.imul(h, 2246822507) >>> 0;
  h ^= h >>> 13;
  h = Math.imul(h, 3266489909) >>> 0;
  // trailing >>> 0 or a negative h gives cde--3, which matches nothing
  h = (h ^ (h >>> 16)) >>> 0;

  var cl = document.documentElement.classList;

  // 1 is the stylesheet default, so it needs no class
  var n = 1 + (h % PATTERNS);
  if (n > 1) cl.add("cde-" + n);

  // a different slice, so pattern and angle vary independently
  var r = (h >>> 8) % ROTATIONS;
  if (r > 0) cl.add("cde-r" + r);
})();

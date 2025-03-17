  // Créer la scène
  const scene = new THREE.Scene();
  scene.background = new THREE.Color(0x000000);

  // Créer la caméra
  const camera = new THREE.PerspectiveCamera(75, 800 / 600, 0.1, 1000);
  camera.position.z = 10;


  // Créer le canvas
  const canvas = document.getElementById('canvas');

  // Créer le renderer
  const renderer = new THREE.WebGLRenderer({
    canvas: canvas,
    antialias: true
  });

  function randomColorBetween(color1, color2) {
    const r = color1.r + (color2.r - color1.r) * Math.random();
    const g = color1.g + (color2.g - color1.g) * Math.random();
    const b = color1.b + (color2.b - color1.b) * Math.random();
    return { r: Math.round(r), g: Math.round(g), b: Math.round(b) };
  }
  
  function toHexColor(color) {
    const r = color.r.toString(16).padStart(2, '0');
    const g = color.g.toString(16).padStart(2, '0');
    const b = color.b.toString(16).padStart(2, '0');
    return `#${r}${g}${b}`;
  }
  
  const colorMin = { r: 255, g: 0, b: 0 }; // Rouge
  const colorMax = { r: 255, g: 255, b: 255 }; // Blanc


  // Définir la taille du renderer
  renderer.setSize(800, 600);

  // Créer les étoiles
  const stars = [];
  for (let i = 0; i < 5000; i++) {
    const geometry = new THREE.SphereGeometry(Math.random() / 10, 8, 8);
    const material = new THREE.MeshBasicMaterial({ color: toHexColor(randomColorBetween(colorMin, colorMax)) });
    const star = new THREE.Mesh(geometry, material);

    const angle = Math.random() * Math.PI * 2;
    const distance = Math.random() * 6 + 1;
    star.position.x = distance * Math.cos(angle);
    star.position.y = distance * Math.sin(angle);
    star.position.z = Math.random() * 2 - 1;

    scene.add(star);
    stars.push({ star, angle, distance });
  }
  
  // Ajouter d'une lumière pour la scene
  const light = new THREE.PointLight(0xffffff, 1, 100);
  light.position.set(0, 0, 5);
  scene.add(light);

  let lastTime = 0;

  let fps = 0;

  // Calcul animation
  function animate(timestamp) {
    // Delta time
    const deltaTime = (timestamp - lastTime) / 1000;
    lastTime = timestamp;

    // Calcul new position
    stars.forEach((star) => {
      let speed = 1 / Math.sqrt(star.distance);
      speed *= Math.max(0.1, 1 / star.distance);
      star.angle += deltaTime * speed;
      star.star.position.x = star.distance * Math.cos(star.angle);
      star.star.position.y = star.distance * Math.sin(star.angle);
    })

    renderer.render(scene, camera);

    // FPS
    fps = 1 / deltaTime;
    document.getElementById('fps').textContent = `FPS : ${Math.round(fps)}`;

    requestAnimationFrame(animate);
  }

  animate(0.1);
const sayHello = name => {
  return `Hello ${name}. It works!`;
};

console.log(sayHello("Buddy"))
document.getElementById("greeting").innerHTML = sayHello("Marcelo");

// игровое поле 
const canvas = document.getElementById('game');
const context = canvas.getContext('2d');
// размер 1 клетки поля 
const cellSize = 20;
// скорость игры 
var gameSpeed = 0;

// параметры змейки
var snake = {
  //координаты на поле
  x: 200,
  y: 200,
  // скорость змейки 
  xSpeed: cellSize,
  ySpeed: 0,
  // тело змейки 
  snakeBody: [],
  //длина тела змейки 
  snakeBodyLength: 4
};

//координаты еды 
const eat = {
  x: 400,
  y: 400
};

// генератор случайныйх чисел в заданом нами диапазоне 
function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min)) + min;
}

// если змейка достигла края поля 
function snakeBorder() {
  // Если змейка достигла края поля по горизонтали — продолжаем её движение с противоположной строны
  if (snake.x < 0) {
    snake.x = canvas.width - cellSize;
  }
  if (snake.x >= canvas.width) {
    snake.x = 0;
  }
  // Делаем то же самое для движения по вертикали
  if (snake.y < 0) {
    snake.y = canvas.height - cellSize;
  }
  if (snake.y >= canvas.height) {
    snake.y = 0;
  }
}

// обрабатываем столкновение змейки с самой собой 
function snakeDead(index, cell_x, cell_y) {
  for (var i = index + 1; i < snake.snakeBody.length; i++) {
    // Если такие клетки есть — начинаем игру заново
    if (cell_x === snake.snakeBody[i].x && cell_y === snake.snakeBody[i].y) {
      // Задаём стартовые параметры основным переменным
      snake.x = 160;
      snake.y = 160;
      snake.snakeBody = [];
      snake.snakeBodyLength = 4;
      snake.xSpeed = cellSize;
      snake.ySpeed = 0;
      // Ставим еду в случайное место
      eat.x = getRandomInt(0, 25) * cellSize;
      eat.y = getRandomInt(0, 25) * cellSize;
    }
  }
}

function snakeEat(cellX, cellY) {
  if (cellX === eat.x && cellY === eat.y) {
    snake.snakeBodyLength++;
    eat.x = getRandomInt(0, 25) * cellSize;
    eat.y = getRandomInt(0, 25) * cellSize;
  }
}

// передвидение змейки по полю
function snakeMove() {
  // двигаем змейку
  snake.x += snake.xSpeed;
  snake.y += snake.ySpeed;
  snakeBorder (snake.x, snake.y)
  // добавлеям голову в начало тела змейки и после этого удаляем последний
  snake.snakeBody.unshift({ x: snake.x, y: snake.y });
  if (snake.snakeBody.length > snake.snakeBodyLength) {
    snake.snakeBody.pop();
  }
  // каждое движение змейки мы рисуем 1 новый квадрат
  context.fillStyle = 'black';
  // для каждой клетки змейки
  snake.snakeBody.forEach(function (cell, index) {
    // рисуем квадрат
    context.fillRect(cell.x, cell.y, cellSize - 2, cellSize - 2);
    snakeEat(cell.x, cell.y);
    snakeDead(index, cell.x, cell.y);
  });
}

// основная функция 
function game() {
  // замелдяем скоркость анимации
  requestAnimationFrame(game);
  // замедляем в 6 раза
  if (++gameSpeed < 6) {
    return;
  }
  gameSpeed = 0;
  // очищаем игровое поле 
  context.clearRect(0, 0, canvas.width, canvas.height);
  // Рисуем еду
  context.fillStyle = 'red';
  context.fillRect(eat.x, eat.y, cellSize - 2, cellSize - 2);
  snakeMove();
}

document.addEventListener("keydown", handleKeyPress);
function handleKeyPress(event)
{
    // Стрелка влево
    if (event.which === 37 && snake.xSpeed === 0) {
      snake.xSpeed = -cellSize;
      snake.ySpeed = 0;
    }
    // Стрелка вверх
    if (event.which === 38 && snake.ySpeed === 0) {
      snake.ySpeed = -cellSize;
      snake.xSpeed = 0;
    }
    // Стрелка вправо
    if (event.which === 39 && snake.xSpeed === 0) {
      snake.xSpeed = cellSize;
      snake.ySpeed = 0;
    }
    // Стрелка вниз
    if (event.which === 40 && snake.ySpeed === 0) {
      snake.ySpeed = cellSize;
      snake.xSpeed = 0;
    }
}
    
// Запускаем игру
requestAnimationFrame(game);

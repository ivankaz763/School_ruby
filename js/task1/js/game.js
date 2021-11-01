// игровое поле 
var canvas = document.getElementById('game');
var context = canvas.getContext('2d');
// размер 1 клетки поля 
var cell_size = 20;
// скорость игры 
var game_speed = 0;

// параметры змейки
var snake = {
  //координаты на поле
  x: 200,
  y: 200,
  // скорость змейки 
  x_speed: cell_size,
  y_speed: 0,
  // тело змейки 
  snake_body: [],
  //длина тела змейки 
  snake_body_length: 4
};

//координаты еды 
var eat = {
  x: 400,
  y: 400
};

// генератор случайныйх чисел в заданом нами диапазоне 
function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min)) + min;
}

// если змейка достигла края поля 
function snake_border() {
  // Если змейка достигла края поля по горизонтали — продолжаем её движение с противоположной строны
  if (snake.x < 0) {
    snake.x = canvas.width - cell_size;
  }
  else if (snake.x >= canvas.width) {
    snake.x = 0;
  }
  // Делаем то же самое для движения по вертикали
  if (snake.y < 0) {
    snake.y = canvas.height - cell_size;
  }
  else if (snake.y >= canvas.height) {
    snake.y = 0;
  }
}

// обрабатываем столкновение змейки с самой собой 
function snake_dead(index, cell_x, cell_y) {
  for (var i = index + 1; i < snake.snake_body.length; i++) {
    // Если такие клетки есть — начинаем игру заново
    if (cell_x === snake.snake_body[i].x && cell_y === snake.snake_body[i].y) {
      // Задаём стартовые параметры основным переменным
      snake.x = 160;
      snake.y = 160;
      snake.snake_body = [];
      snake.snake_body_length = 4;
      snake.x_speed = cell_size;
      snake.y_speed = 0;
      // Ставим еду в случайное место
      eat.x = getRandomInt(0, 25) * cell_size;
      eat.y = getRandomInt(0, 25) * cell_size;
    }
  }
}

// передвидение змейки по полю
function snake_move() {
  // двигаем змейку
  snake.x += snake.x_speed;
  snake.y += snake.y_speed;
  snake_border (snake.x, snake.y)
  // добавлеям голову в начало тела змейки и после этого удаляем последний
  snake.snake_body.unshift({ x: snake.x, y: snake.y });
  if (snake.snake_body.length > snake.snake_body_length) {
    snake.snake_body.pop();
  }
  // каждое движение змейки мы рисуем 1 новый квадрат
  context.fillStyle = 'black';
  // для каждой клетки змейки
  snake.snake_body.forEach(function (cell, index) {
    // рисуем квадрат
    context.fillRect(cell.x, cell.y, cell_size - 2, cell_size - 2);
    // если змейка съела еду то увеличиваем ее размер 
    if (cell.x === eat.x && cell.y === eat.y) {
      snake.snake_body_length++;
      // рисуем новую еду
      eat.x = getRandomInt(0, 25) * cell_size;
      eat.y = getRandomInt(0, 25) * cell_size;
    } 
    snake_dead(index, cell.x, cell.y);
  });
}

// основная функция 
function game() {
  // замелдяем скоркость анимации
  requestAnimationFrame(game);
  // замедляем в 6 раза
  if (++game_speed < 6) {
    return;
  }
  game_speed = 0;
  // очищаем игровое поле 
  context.clearRect(0, 0, canvas.width, canvas.height);
  // Рисуем еду
  context.fillStyle = 'black';
  context.fillRect(eat.x, eat.y, cell_size - 2, cell_size - 2);
  snake_move();
}

// обрабатываем нажатия клавиш 
document.addEventListener('keydown', function (e) {
  // Стрелка влево
  if (e.which === 37 && snake.x_speed === 0) {
    snake.x_speed = -cell_size;
    snake.y_speed = 0;
  }
  // Стрелка вверх
  else if (e.which === 38 && snake.y_speed === 0) {
    snake.y_speed = -cell_size;
    snake.x_speed = 0;
  }
  // Стрелка вправо
  else if (e.which === 39 && snake.x_speed === 0) {
    snake.x_speed = cell_size;
    snake.y_speed = 0;
  }
  // Стрелка вниз
  else if (e.which === 40 && snake.y_speed === 0) {
    snake.y_speed = cell_size;
    snake.x_speed = 0;
  }
});
    
// Запускаем игру
requestAnimationFrame(game);
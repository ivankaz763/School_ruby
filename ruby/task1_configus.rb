
class Configus

    class InHash
        # Геттер для inner_hash
        attr_reader :inner_hash

        def initialize
            # Объявляем пустой хеш
            @inner_hash = {}
        end

        # Проверяем, если нам дали блок - значит запускаем его в новом InHash
        def method_missing(name, *args, &block)
            if block_given?
                # Создаем инстанс контекста
                context = InHash.new
                # Запускаем в нем наш хеш
                context.instance_eval &block 
                # Записываем внутренний хеш
                @inner_hash[name] = context
            elsif args.empty?
                # Если нет ни блока ни аргументов - выдаем ошибку
                @inner_hash[name]
            else
                # Записываем в хеш результат args по ключу name
                @inner_hash[name] = args
            end
        end
    end

    # Возвращает новый хеш с рекурсивным слиянием self_hash и other_hash
    def self.deep_merge(self_hash, other_hash)
      # цикл для всех пар ключ занчение 
      other_hash.inner_hash.each_pair do |key, value|
        tv = self_hash.inner_hash[key]
        self_hash.inner_hash[key] =
          if tv.is_a?(InHash) && value.is_a?(InHash)
            deep_merge(tv, value)
          else
            value
          end
      end
      self_hash
    end

    def self.config(environment, parent = nil, &block)
        # Создаем инстанс хеша
        in_hash = InHash.new
        # Запускаем в нем наш хеш
        in_hash.instance_eval &block

        # Если нужно наследоваться 
        if parent
            parent_hash = in_hash.inner_hash[parent]
            child_hash = in_hash.inner_hash[environment]
            deep_merge(parent_hash, child_hash)
        else 
            in_hash.inner_hash[environment]
        end
    end

end

config = Configus.config :staging, :production do
    production do
      key1 "value1"
      key2 "value2"
      group1 do
        key3 "value3"
        key4 "value4"
      end
    end
   
    staging do
      key2 "new value2"
      group1 do
        key4 "new value4"
      end
    end
  end
   
  p config

  p config.key1
  p config.key2
  p config.group1.key3
  p config.group1.key4




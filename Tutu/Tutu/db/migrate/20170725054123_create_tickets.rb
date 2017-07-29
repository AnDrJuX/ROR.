class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.integer :first_station_id
      t.integer :last_station_id
      t.timestamps
    end
  end
end

# Создать (если еще не созданы) следюущие модели и добавить к ним ассоциации:
# Модель Маршрут имеет множество станций. Станция может принадлежать множеству маршрутов
# Поезд может иметь один маршрут, на одном маршруте может быть несколько поездов
# Билет содержит информацию о (связан с) поезде, начальной и конечной станциях. Билет принадлежит пользователю
# Пользователь может иметь произвольное кол-во билетов
# Поезд содержит информацию о билетах на него.
# Поезд связан с текущей станцией (ассоциация должна называться current_station)
# Станция имеет множество поездов (все поезда, у которых установлена ассоциация current_station с этой станцией)


# Замени связь has_and_belongs_to_many на has_many through
# Билет принадлежит не маршруту, а поезду. А вот поезд уже связан с маршрутом
# У билета должны быть начальная и конечная станция, т.к. билет может продаваться на часть маршрута



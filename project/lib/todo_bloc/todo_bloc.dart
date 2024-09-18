import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import '../data/todo.dart'; // Import correto da classe Todo

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    
    // Adicionando handler para o evento TodoStarted
    on<TodoStarted>((event, emit) {
      emit(state.copyWith(status: TodoStatus.success));
    });

    on<AddTodo>((event, emit) {
      emit(state.copyWith(
        todos: List.from(state.todos)..add(event.todo),
        status: TodoStatus.success,
      ));
    });

    on<RemoveTodo>((event, emit) {
      emit(state.copyWith(
        todos: List.from(state.todos)..remove(event.todo),
        status: TodoStatus.success,
      ));
    });

    on<AlterTodo>((event, emit) {
      List<Todo> updatedTodos = List.from(state.todos);
      Todo updatedTodo = updatedTodos[event.index].copyWith(
        isDone: !updatedTodos[event.index].isDone,
      );
      updatedTodos[event.index] = updatedTodo;
      emit(state.copyWith(todos: updatedTodos, status: TodoStatus.success));
    });
  }

  @override
  TodoState fromJson(Map<String, dynamic> json) {
    try {
      return TodoState.fromJson(json);
    } catch (_) {
      return const TodoState();
    }
  }

  @override
  Map<String, dynamic> toJson(TodoState state) {
    return state.toJson();
  }
}

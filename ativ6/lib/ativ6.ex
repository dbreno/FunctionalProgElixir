defmodule Ativ6 do
  # Recursividade de cauda e acumuladores

  # Escreva as funcoes a seguir usando recursividade de cauda. Se precisar,
  # crie funcoes auxiliares que usam um parametro acumulador.

  # Obs: os testes nao vao testar se as funcoes apresentam recursividade
  # de cauda ou nao, apenas se o objetivo da funcao e' cumprido. Mas a
  # avaliação levará em conta, funções que não sejam recursivas de cauda
  # ou chamem funções já prontas da biblioteca padrão Elixir serão
  # penalizadas.


# ==========================================================================

  @doc "Obtem o tamanho da lista l."

  # Chama a função auxiliar com a lista e o acumulador inicializado em 0
  def tamanho(l), do: tamanho_aux(l, 0)

  # Retorna o acumulador quando a lista estiver vazia
  defp tamanho_aux([], acc), do: acc
  # Chama a si mesma com a cauda da lista e o acumulador incrementado em 1
  defp tamanho_aux([_ | tail], acc), do: tamanho_aux(tail, acc + 1)

# ==========================================================================

  @doc """
  Replica a string s, n vezes.

  Exemplo:
  iex> Ativ6.replica("ruby", 4)
  "rubyrubyrubyruby"
  """

  # Chama a função auxiliar com a string, o número de repetições e o acumulador
  # inicializado como uma string vazia.
  def replica(s, n), do: replica_aux(s, n, "")

  # Retorna o acumulador quando o número de repetições for 0
  defp replica_aux(_s, 0, acc), do: acc
  # Chama a si mesma com o número de repetições decrementado e
  # o acumulador concatenado com a string
  defp replica_aux(s, n, acc), do: replica_aux(s, n - 1, acc <> s)

# ==========================================================================

  #
  # Funções que usam listas como acumuladores geralmente precisam retornar
  # o reverso da lista acumulada. É importante que a função que calcula
  # o reverso de uma lista apresente recursividade de cauda, caso
  # contrário a vantagem de mudar uma função para usar acumuladores
  # se perde.
  #

  @doc """
  Obtém uma lista com os mesmos elementos da lista l, mas na ordem
  reversa.

  Exemplo:
  iex> Ativ6.reverso([1, 2, 3, 4])
  [4, 3, 2, 1]
  """

  # Chama a função auxiliar com a lista e o acumulador
  # inicializado como uma lista vazia
  def reverso(l), do: reverso_aux(l, [])

  # Retorna o acumulador quando a lista estiver vazia
  defp reverso_aux([], acc), do: acc
  # Chama a si mesma com a cauda da lista e o acumulador
  # atualizado com o elemento da cabeça da lista
  defp reverso_aux([head | tail], acc), do: reverso_aux(tail, [head | acc])

# ==========================================================================

  # A função reverso deve ser usada nas funções a seguir que acumulam
  # listas, como map e filter.

  @doc """
  Aplica a funcao f em cada elemento da lista l, retornando uma nova lista
  com os elementos transformados.

  Exemplo:
  iex> Ativ6.map([1, 2, 3], fn x -> x * 2 end)
  [2, 4, 6]
  """

  # Chama a função auxiliar com a lista, a função f e
  # o acumulador inicializado como uma lista vazia
  # usar a função reverso/1 para lidar com o acumulador
  def map(l, f), do: map_aux(l, f, [])

  # Retorna o acumulador (reverso) quando a lista estiver vazia
  defp map_aux([], _f, acc), do: reverso(acc)
  # Chama a si mesma com a cauda da lista e o acumulador atualizado
  # com o resultado da aplicação de f ao elemento da cabeça da lista
  defp map_aux([head | tail], f, acc), do: map_aux(tail, f, [f.(head) | acc])

# ==========================================================================

  @doc "Calcula a soma dos numeros da lista l."

  # Chama a função auxiliar com a lista e o acumulador inicializado em 0
  def soma_lista(l), do: soma_lista_aux(l, 0)

  # Retorna o acumulador quando a lista estiver vazia
  defp soma_lista_aux([], acc), do: acc
  # Chama a si mesma com a cauda da lista e o acumulador
  # incrementado com o valor da cabeça da lista
  defp soma_lista_aux([head | tail], acc), do: soma_lista_aux(tail, acc + head)


# ==========================================================================

  @doc "Calcula o produto dos numeros da lista l."

  # Chama a função auxiliar com a lista e o acumulador inicializado em 1
  def mult_lista(l), do: mult_lista_aux(l, 1)

  # Retorna o acumulador quando a lista estiver vazia
  defp mult_lista_aux([], acc), do: acc
  # Chama a si mesma com a cauda da lista e o acumulador multiplicado pelo
  # valor da cabeça da lista
  defp mult_lista_aux([head | tail], acc), do: mult_lista_aux(tail, acc * head)


# ==========================================================================

  @doc "Retorna uma string que e' a concatenacao de todas as strings na lista ls."

  # Chama a função auxiliar com a lista e o acumulador
  # inicializado como uma string vazia
  def concat_lista(ls), do: concat_lista_aux(ls, "")

  # Retorna o acumulador quando a lista estiver vazia
  defp concat_lista_aux([], acc), do: acc
  # Chama a si mesma com a cauda da lista e o acumulador
  # concatenado com a string da cabeça da lista
  defp concat_lista_aux([head | tail], acc), do: concat_lista_aux(tail, acc <> head)

# ==========================================================================

  @doc """
  Retorna uma lista com os elementos da lista l para os quais o predicado p
  returna true.

  Exemplo:
  iex> Ativ6.filter([10, 2, 15, 9, 42, 27], fn x -> x > 10 end)
  [15, 42, 27]
  """

  # Chama a função auxiliar com a lista, o predicado e o acumulador inicializado
  # como uma lista vazia
  def filter(l, p), do: filter_aux(l, p, [])

  # Retorna o acumulador (reverso) quando a lista estiver vazia
  defp filter_aux([], _p, acc), do: reverso(acc)

  # Verifica se o elemento da cabeça da lista satisfaz o predicado:
  defp filter_aux([head | tail], p, acc) do
    if p.(head) do # p é uma função anônima, por isso pode usar a notação .(argumentos)
      filter_aux(tail, p, [head | acc]) # Caso sim, adiciona o elemento ao acumulador
    else
      filter_aux(tail, p, acc) # Senão, continua com o acumulador inalterado
    end
  end

# ==========================================================================

  # Opcional: fold_right com recursão de cauda

  # Vimos que duas funções de alta ordem importantes são
  # fold_left e fold_right, que combinam os elementos de uma lista
  # usando uma função passada como parâmetro. A diferença entre
  # fold_left e fold_right é a direção que as operações são agrupadas.
  #
  # Por exemplo, combinando a lista [1, 2, 3] com a operação de soma
  # e elemento inicial 0, fold_left faz (((0 + 1) + 2) + 3), agrupando
  # as somas à esquerda. Já fold_right faz as operações na ordem
  # (1 + (2 + (3 + 0))), agrupando à direita. Para a soma o resultado
  # será o mesmo, mas em operações não associativas como subtração é
  # importante escolher a direção.

  # A função fold_left, da forma que ela normalmente é escrita, já
  # tem recursão em cauda:

  # OBS: modifiquei as variáveis do código original, para perpetuar a semântica
  # das funções anteriores :)


  # Aplica a função f da esquerda para a direita, acumulando o resultado em acc
  def fold_left([], _f, acc), do: acc
  # Usa recursividade de cauda
  def fold_left([head | tail], f, acc), do: fold_left(tail, f, f.(acc, head))

  # Já fold_right normalmente não é recursiva em cauda:

  # OBS: modifiquei as variáveis do código original, para perpetuar a semântica
  # das funções anteriores :)

  # Aplica a função f da direita para a esquerda, acumulando o resultado em acc
  def fold_right([], _f, acc), do: acc
  # Não usa recursividade de cauda
  def fold_right([head | tail], f, acc), do: f.(head, fold_right(tail, f, acc))

  # Para este exercício opcional, crie uma versão de fold_right
  # com recursividade de cauda. Adicione testes para verificar
  # a funcionalidade da versão com recursividade de cauda.

# -----------------------------------------------------------
  def fold_right_tail(l, f, acc) do
    l
    # Inverte a lista usando a função auxiliar lista_reversa/2
    |> lista_reversa([])
    # Aplica a função f da direita para a esquerda usando a função auxiliar
    # fold_right_tail_aux/3, que usa recursividade de cauda
    |> fold_right_tail_aux(f, acc)
  end

  defp lista_reversa([], acc), do: acc
  defp lista_reversa([head | tail], acc), do: lista_reversa(tail, [head | acc])

  defp fold_right_tail_aux([], _f, acc), do: acc
  defp fold_right_tail_aux([head | tail], f, acc), do: fold_right_tail_aux(tail, f, f.(head, acc))
# -----------------------------------------------------------

@moduledoc false
"""
Alguns testes utilizados:

test "fold_left com soma" do
  assert Ativ6.fold_left([1, 2, 3], &(&1 + &2), 0) == 6
end

test "fold_left com multiplicação" do
  assert Ativ6.fold_left([1, 2, 3, 4], &(&1 * &2), 1) == 24
end

test "fold_left com subtração" do
  assert Ativ6.fold_left([1, 2, 3], &(&1 - &2), 0) == -6
end

test "fold_right_tail com soma" do
  assert Ativ6.fold_right_tail([1, 2, 3], &(&1 + &2), 0) == 6
end

test "fold_right_tail com multiplicação" do
  assert Ativ6.fold_right_tail([1, 2, 3, 4], &(&1 * &2), 1) == 24
end

test "fold_right_tail com subtração" do
  assert Ativ6.fold_right_tail([1, 2, 3], &(&1 - &2), 0) == 2
end

"""

end

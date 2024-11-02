# PFL_Project

### Group T10_G03

- Ana Sofia Baptista: up202207334
- Martim Moniz: up202206958

#### Contribuição para o Trabalho:

- Ana Sofia Baptista:
- Martim Moniz:

## Função shortestPath

#### Objetivo:
A função `shortestPath` tem como principal objetivo calcular todos os caminhos mais curtos entre duas cidades específicas num mapa. O mapa é representado por um grafo não-direcionado, onde as cidades são os vértices e as estradas (com distâncias associadas) são as arestas. Esta função recebe duas cidades de entrada e retorna uma lista que contém o caminho com a menor distância entre essas cidades. Caso não haja caminho possível, a função retorna uma lista vazia.

Ao usar o algoritmo de pesquisa em largura (BFS) para explorar todos os caminhos possíveis entre duas cidades, é de esperar que existam múltiplas rotas com a mesma distância mínima. Nessa situação, uma deles vai ser retornada. A função também lida com o caso da cidade de partida ser igual à cidade de destino e portanto, nesse caso, não será necessário percorrer o mapa, pois o caminho mais curto será precisamente essa cidade. 

#### Algoritmo usado - BFS:
A função `shortestPath` utiliza o algoritmo de Pesquisa em Largura (BFS) para encontrar todos os caminhos mais curtos entre duas cidades num grafo não-direcionado. A escolha do BFS é ideal neste caso, pois num grafo onde todas as arestas são consideradas com o mesmo "peso", este algoritmo garante que os caminhos mais curtos sejam explorados primeiro.

O algoritmo começa ao inicializar o processo na cidade de partida, colocando o caminho actual numa fila para processamento. Em seguida, expande cada caminho ao explorar todos os vizinhos ligados directamente à última cidade visitada. Estes novos caminhos gerados são adicionados à fila, permitindo uma exploração organizada de todas as rotas possíveis.

Sempre que o algoritmo alcança a cidade de destino, guarda o caminho como uma solução de menor distância. Para evitar ciclos, garante que as cidades já visitadas num caminho não sejam revisitadas, assegurando assim que cada solução é realmente o percurso mais curto. Quando todos os caminhos de menor distância entre as duas cidades são encontrados, o algoritmo devolve a lista completa desses percursos.

Esta implementação do BFS é eficiente para explorar grafos com caminhos de igual custo e permite identificar todos os possíveis percursos de menor distância entre duas cidades no grafo, retornando uma lista de soluções para o problema proposto.

#### Como foi implementada:

- 


## Função travelSales

#### Como foi implementada:

- 

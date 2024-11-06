# PFL_Project

### Group T10_G03

- Ana Sofia Baptista: up202207334
- Martim Moniz: up202206958

#### Contribuição para o Trabalho:

- Ana Sofia Baptista: 50% Funções Implementadas: 2, 3, 6, 8, 9
- Martim Moniz: 50% Funções Implementadas: 1, 4, 5, 6, 7

## Função shortestPath

#### Objetivo:
A função `shortestPath` tem como principal objetivo calcular todos os caminhos mais curtos entre duas cidades específicas num mapa. O mapa é representado por um grafo não-direcionado, onde as cidades são os vértices e as estradas (com distâncias associadas) são as arestas. Esta função recebe duas cidades de entrada e retorna uma lista que contém o caminho com a menor distância entre essas cidades. Caso não haja caminho possível, a função retorna uma lista vazia.

Ao usar o algoritmo de pesquisa em largura (BFS) para explorar todos os caminhos possíveis entre duas cidades, é de esperar que existam múltiplas rotas com a mesma distância mínima. Nessa situação, uma deles vai ser retornada. A função também lida com o caso da cidade de partida ser igual à cidade de destino e portanto, nesse caso, não será necessário percorrer o mapa, pois o caminho mais curto será precisamente essa cidade. 

#### Algoritmo usado - BFS:
A função `shortestPath` utiliza o algoritmo de Pesquisa em Largura (BFS) para encontrar todos os caminhos mais curtos entre duas cidades num grafo não-direcionado. A escolha do BFS é ideal neste caso, pois num grafo onde todas as arestas são consideradas com o mesmo "peso", este algoritmo garante que os caminhos mais curtos sejam explorados primeiro.

O algoritmo começa ao inicializar o processo na cidade de partida, colocando o caminho actual numa fila para processamento. Em seguida, expande cada caminho ao explorar todos os vizinhos ligados directamente à última cidade visitada. Estes novos caminhos gerados são adicionados à fila, permitindo uma exploração organizada de todas as rotas possíveis.

Sempre que o algoritmo alcança a cidade de destino, guarda o caminho como uma solução de menor distância. Para evitar ciclos, garante que as cidades já visitadas num caminho não sejam revisitadas, assegurando assim que cada solução é realmente o percurso mais curto. Quando todos os caminhos de menor distância entre as duas cidades são encontrados, o algoritmo devolve a lista completa desses percursos.

Esta implementação do BFS é eficiente para explorar grafos com caminhos de igual custo e permite identificar todos os possíveis percursos de menor distância entre duas cidades no grafo, retornando uma lista de soluções para o problema proposto.

#### Justificação das Estruturas de Dados Auxiliares:
Foram usadas listas para representar os caminhos durante a execução do BFS devido à sua flexibilidade e simplicidade. A lista de caminhos (`[Path]`) é uma estrutura de dados fundamental, pois permite armazenar todos os caminhos explorados de forma eficiente. Em cada iteração, a lista de caminhos é atualizada com as cidades adjacentes, permitindo manter o controlo sobre quais caminhos já foram explorados e quais ainda estão em expansão.

## Função travelSales - Programação Dinâmica com Bitmasking

#### Objetivo:
A função `travelSales` tem como objetivo resolver o problema do Caixeiro Viajante (Traveling Salesman Problem - TSP), que consiste em encontrar a rota de menor custo que visita um conjunto de cidades exatamente uma vez e retorna à cidade de origem. A função utiliza um mapa rodoviário (RoadMap) como entrada e devolve o caminho ótimo a ser percorrido.

#### Algoritmo usado - Programação Dinâmica com BitMasking:
O algoritmo implementado para resolver o TSP baseia-se em programação dinâmica com bitmasking. A abordagem envolve a construção de uma matriz de adjacência (`AdjMatrix`) que armazena as distâncias entre cada par de cidades. A função tsp é uma função recursiva que utiliza uma tabela de memoização para evitar cálculos redundantes, armazenando resultados previamente computados para combinações de cidades visitadas e posições atuais. O algoritmo explora todos os caminhos possíveis e seleciona o que tem a menor distância total, garantindo assim uma solução eficiente para o problema, mesmo com um número elevado de cidades.

#### Justificação das Estruturas de Dados Auxiliares:
A escolha das estruturas de dados auxiliares na função `travelSales` é fundamental para garantir a eficiência e a clareza do algoritmo. A matriz de adjacência (`AdjMatrix`) permite o armazenamento eficiente das distâncias entre as cidades, facilitando consultas rápidas sobre os custos associados a cada par de cidades. A tabela de memoização, é crucial para otimizar o algoritmo, armazenando resultados já calculados para combinações de cidades visitadas e a posição atual, evitando a recomputação. A técnica de bitmasking é utilizada para representar o estado das cidades, permitindo uma manipulação eficiente dos conjuntos visitados e proporcionando uma forma compacta de controlar quais foram as cidades visitadas até ao momento.

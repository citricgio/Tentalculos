# Tentálculos

Serious Game para iOS que ensina **equações do 1º grau** a alunos do Ensino Fundamental II. Você é um polvo garçom no fundo do mar e precisa equilibrar os pedidos dos clientes, que são equações, colocando frutas nos pratos de uma balança.

O nome é uma junção de **Tentáculos** e **Cálculos**.

Projeto desenvolvido na **Apple Developer Academy | Mackenzie** e inspirado no *Balance Scale Equation Game*, do Laboratório de Matemática da Universidade Presbiteriana Mackenzie.

<img width="1920" height="1080" alt="Slide 16_9 - 33" src="https://github.com/user-attachments/assets/de026023-3ed2-4d47-9184-57e3c04f8c88" />

## Por que este projeto?

A pandemia de COVID-19 aumentou a defasagem de aprendizado em Matemática no Brasil. Em 2022, 73% dos estudantes brasileiros de 15 anos ficaram abaixo do nível 2 de letramento matemático no Pisa, ou seja, não conseguiam fazer operações simples. O Tentálculos propõe uma forma prática e divertida de aproximar os alunos de um conteúdo central dessa fase: resolver equações do 1º grau.

## Como o jogo funciona

O jogo gera uma equação aleatória e a representa como uma balança de dois pratos. Cada lado da equação é um prato, e as frutas valem números. O objetivo é **isolar a incógnita**, aplicando o mesmo passo nos dois lados, como na balança original.

Exemplo: `x + 5 = 7`. Se você tira 5 de um lado, precisa tirar 5 do outro. Resultado: `x = 2`.

1. O jogador monta o prato com as frutas que correspondem à equação.
2. Na segunda etapa, aplica subtração ou divisão. As frutas dos dois pratos são trocadas de acordo com a operação.
3. Quando a balança chega ao valor da incógnita, a equação está resolvida.

As equações têm dois níveis de dificuldade:

| Nível | Forma | Exemplo |
|---|---|---|
| Básico | `b + x = peso` | `3 + x = 7` |
| Intermediário | `b + 2x = peso` | `3 + 2x = 9` |

## Tecnologias

- **Swift 5**
- **SwiftUI**: menu, navegação e tutorial
- **SpriteKit**: lógica e apresentação visual do jogo
- **Game Center**: pontuação
- Design: Figma e Adobe Illustrator (estilo vetorial 2D)

## Estrutura do projeto

```
PolvoPolvoGame/
├── PolvoPolvoGameApp.swift   # ponto de entrada do app
├── Views/                    # telas SwiftUI (ContentView, TutorialView)
├── Scenes/                   # cenas SpriteKit: menu, jogo, tutorial, fim de jogo e botões
├── Scripts/                  # lógica: EquationGenerator, Calculator, DataBalance
├── Models/                   # DataModel, GamePlayData, GameCenterController
├── Enum/                     # frutas, operações e fontes
├── Extensions/               # extensões de SKScene e de redução de frutas
├── Sound/                    # músicas e efeitos
├── Resources/                # fontes (Istok Web)
└── Assets.xcassets/          # imagens: polvo, frutas, pratos, botões e cenário
```

A lógica do jogo se divide em três partes:

1. **Geração das equações aleatórias** (`EquationGenerator`).
2. **Cálculo dos pesos**: atribui valores aos dois lados e calcula o valor da incógnita (`Calculator`, `DataBalance`).
3. **Troca de frutas** na segunda etapa, quando ocorre subtração ou divisão.

## Artigo

Este projeto é descrito no *demo paper*:

> LIMA, B. M.; SABAINI, G. P. T.; SANTANA, G. M.; LIPORACE, T. L.; LEITE, P. T.; BRAGA, P. H. C.; AZEVEDO, V. L. A. **Exploring the Potential of Serious Games for Learning Mathematical Equations**. Universidade Presbiteriana Mackenzie.

Publicado pela Springer: [link.springer.com/chapter/10.1007/978-3-031-74138-8_29](https://link.springer.com/chapter/10.1007/978-3-031-74138-8_29)

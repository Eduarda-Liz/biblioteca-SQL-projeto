create database Biblioteca;
use Biblioteca;

create table autor(
id_autor int primary key,
nome varchar(100) not null,
nacionalidade varchar(100),
ano_nascimento int
);

create table editora (
id_editora int primary key,
nome varchar(100) not null,
cidade varchar(100)
);

create table categoria (
id_categoria int primary key,
nome_categoria varchar(100)
);

create table livro (
id_livro int primary key,
titulo varchar(100) not null,
ano_publicacao int,
quantidade_estoque int,
id_autor int,
id_editora int,
id_categoria int,

foreign key (id_autor) references autor(id_autor),
foreign key (id_editora) references editora(id_editora),
foreign key (id_categoria) references categoria(id_categoria)
);

create table cliente (
id_cliente int primary key,
nome varchar(100) not null,
email varchar(100),
telefone varchar(20),
data_cadastro varchar(30)
);

create table emprestimo (
id_emprestimo int primary key,
data_emprestimo varchar(30),
data_devolucao_prevista varchar(30),
data_devolucao varchar(30),
id_cliente int,

foreign key (id_cliente) references cliente(id_cliente)
);

create table item_emprestimo(
id_item int primary key,
id_emprestimo int,
id_livro int,
quantidade int not null,

foreign key (id_emprestimo) references emprestimo(id_emprestimo),
foreign key (id_livro) references livro(id_livro)
);

insert into autor values 
(1, 'Robert C. Martin', 'Estados Unidos', 1952),
(2, 'Clive Staples Lewis', 'Reino Unido', 1898),
(3, 'J. K. Rowling', 'Reino Unido', 1965),
(4, 'Aditya Y. Bhargava', 'Índia', 1980),
(5, 'Benjamin Graham', 'Reino Unido', 1894),
(6, 'Morgan Housel', 'Estados Unidos', 1984);

INSERT INTO editora VALUES
(1, 'Alta Books', 'Rio de Janeiro'),
(2, 'WMF Martins Fontes', 'São Paulo'),
(3, 'Rocco', 'Rio de Janeiro'),
(4, 'Novatec Editora', 'São Paulo'),
(5, 'HarperCollins', 'Rio de Janeiro');

INSERT INTO categoria VALUES
(1, 'Informática'),
(2, 'Fantasia'),
(3, 'Finanças');

insert into livro values 
(1, 'Código Limpo', 2008, 2, 1, 1, 1),
(2, 'As Crônicas de Nárnia: O Leão, a Feiticeira e o Guarda-Roupa',
1950, 1, 2, 2, 2),
(3, 'Harry Potter e as Relíquias da Morte',
2007, 1, 3, 3, 2),
(4, 'Harry Potter e a Pedra Filosofal',
1997, 2, 3, 3, 2),
(5, 'Entendendo Algoritmos: Um Guia Ilustrado',
2017, 5, 4, 4, 1),
(6, 'O Investidor Inteligente',
1949, 2, 5, 5, 3),
(7, 'A Psicologia Financeira',
2020, 2, 6, 5, 3);

insert into cliente values
(1, 'João Silva', 'joao@email.com', '51999990001', '2024-01-15'),
(2, 'Maria Oliveira', 'maria@email.com', '51999990002', '2024-02-20'),
(3, 'Pedro Santos', 'pedro@email.com', '51999990003', '2024-03-10'),
(4, 'Ana Costa', 'ana@email.com', '51999990004', '2024-04-05');

insert into emprestimo values
(1, '2025-05-01', '2025-05-15', '2025-05-14', 1),
(2, '2025-05-10', '2025-05-24', '2025-05-22', 2),
(3, '2025-05-20', '2025-06-03', null, 3),
(4, '2025-06-01', '2025-06-15', null, 1),
(5, '2025-06-05', '2025-06-19', null, 4);

insert into item_emprestimo values
(1, 1, 1, 1),  -- Código Limpo
(2, 1, 5, 1),  -- Entendendo Algoritmos
(3, 2, 3, 1),  -- Relíquias da Morte
(4, 3, 4, 1),  -- Pedra Filosofal
(5, 3, 2, 1),  -- Nárnia
(6, 4, 6, 1),  -- Investidor Inteligente
(7, 5, 7, 1),  -- Psicologia Financeira
(8, 5, 1, 1);  -- Código Limpo

select titulo, ano_publicacao 
from livro 
where ano_publicacao > 2000 order by ano_publicacao desc;

select l.titulo, c.nome_categoria 
from livro as l
inner join categoria as c 
on l.id_categoria = c.id_categoria 
order by c.nome_categoria asc;

select c.nome_categoria, COUNT(l.id_livro) as quantidade
from categoria c 
inner join livro l
on c.id_categoria = l.id_categoria
group by c.nome_categoria;

select c.nome, COUNT(e.id_emprestimo) as quantidade_emprestimo
from cliente c
inner join emprestimo e
on c.id_cliente = e.id_cliente 
group by c.nome;

select c.nome, SUM(i.quantidade) as total_livros
from cliente c
inner join emprestimo e
on c.id_cliente = e.id_cliente

inner join item_emprestimo i
on e.id_emprestimo = i.id_emprestimo
group by c.nome;

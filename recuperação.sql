create table investidores (
	id serial primary key,
	nome varchar(100) not null,
	cpf varchar(11) not null unique,
	nivel_experiencia int not null check(nivel_experiencia >= 0)
);

create table carteiras (
	id serial primary key,
	investidor_id int not null,
	endereco_wallet varchar(100) not null unique,
	rede_blockchain varchar (100) not null,
	saldo_usd numeric(10,2) not null,
	status varchar(100) default 'ativa' check(status in('ativa', 'em analise', 'bloqueada', 'pausada')),

	foreign key (investidor_id)
	references investidores(id)

);

create table corretoras (
	id serial primary key,
	nome_exchange varchar(100),
	cnpj varchar(11),
	email_suporte varchar(100) not null unique
);

create table criptomoedas (
	id serial primary key,
	corretora_id int not null,
	nome_moeda varchar(100) not null,
	preco_unitario_usd numeric(10,2) check(preco_unitario_usd > 0),
	categoria varchar(100) default 'layer1' check (categoria in ('layer1', 'defi', 'memecoin', 'stablecoin')),

	foreign key (corretora_id) 
	references corretoras(id)
);

create table tansacoes_cripto (
	id serial primary key,
	carteira_id int not null,
	criptomoeda_id int not null,
	quantidade numeric(10,2) not null unique check(quantidade > 0),
	valor_pago numeric(10,2) not null unique check(valor_pago > 0),
	data_transacao timestamp default current_timestamp,

	foreign key (carteira_id)
	references carteiras(id),

	foreign key (criptomoeda_id)
	references criptomoedas(id)
	
);

insert into investidores (nome, cpf, nivel_experiencia)
values
('felipe lopez', '12345678901', 2),
('manuela urbano', '23456789012', 5),
('lucca matheus', '34567890123', 1),
('nicolas gabriel', '45678901234', 3),
('guilherme ribeiro', '56789012345', 4);

insert into carteiras
(investidor_id, endereco_wallet, rede_blockchain, saldo_usd, status)
values
(1, '0xabc123', 'ethereum', 5000.00, 'ativa'),
(2, '0xdef456', 'bitcoin', 8000.00, 'em analise'),
(3, '0xghi789', 'solana', 1200.00, 'bloqueada'),
(4, '0xjkl012', 'ethereum', 3500.00, 'pausada'),
(5, '0xmno345', 'bitcoin', 9500.00, 'ativa');

insert into corretoras
(nome_exchange, cnpj, email_suporte)
values
('foxbit', '12345678901', 'suporte@binance.com'),
('inter', '23456789012', 'suporte@coinbase.com'),
('gremio', '34567890123', 'suporte@kraken.com'),
('binance', '45678901234', 'suporte@bybit.com'),
('coinbase', '56789012345', 'suporte@okx.com');

insert into criptomoedas
(corretora_id, nome_moeda, preco_unitario_usd, categoria)
values
(1, 'solana', 95000.00, 'layer1'),
(2, 'fluminense', 3200.00, 'layer1'),
(3, 'bitcoin', 8.50, 'defi'),
(4, 'dogecoin', 0.25, 'memecoin'),
(5, 'usdt', 1.00, 'stablecoin');

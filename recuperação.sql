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
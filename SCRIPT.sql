-- Criação da tabela dos operadores
IF OBJECT_ID('dbo.OPERADORES', 'U') IS NOT NULL 
	DROP TABLE dbo.OPERADORES;
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OPERADORES](
	[OPERADORESID] [int] IDENTITY(1,1) NOT NULL,
	[CODIGO] [char](30) NULL DEFAULT '*',
	[NOME] [varchar](60) NULL DEFAULT '*',
	[EMAIL] [varchar](60) NULL DEFAULT '*',
	[PASSWORD] [varchar](60) NULL DEFAULT '*',
	[NOTAS] [varchar](max) NULL DEFAULT '',
	[CTRLDATA] [datetime] NOT NULL DEFAULT GETDATE(),
	[CTRLCODOP] [char](15) NOT NULL DEFAULT '*',
	[TELEFONE] [varchar](20) NULL DEFAULT '',
	[TELEMOVEL] [varchar](20) NULL DEFAULT '',
	[LASTLOGIN] [datetime] NULL,
	[ADMINISTRADOR] [BIT] NOT NULL DEFAULT 0,
	[ESCRITA] [BIT] NOT NULL DEFAULT 0,
	[LEITURA] [BIT] NOT NULL DEFAULT 1,
	[ATIVO] [BIT] NOT NULL DEFAULT 1,
	[VISIVEL] [BIT] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_OPERADORES] PRIMARY KEY CLUSTERED 
(
	[OPERADORESID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [IX_OPERADORES_CODIGO] UNIQUE NONCLUSTERED 
(
	[CODIGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


INSERT INTO OPERADORES(CODIGO,NOME,EMAIL,[PASSWORD], NOTAS, TELEFONE, TELEMOVEL, LASTLOGIN, ADMINISTRADOR, ESCRITA, LEITURA, ATIVO, VISIVEL)
SELECT 'APL', 'André Lourenço', 'afonsopereira6@gmail.com', 'liedson31', '', '', '912803666', null, 1, 1, 1, 1, 1

INSERT INTO OPERADORES(CODIGO,NOME,EMAIL,[PASSWORD], NOTAS, TELEFONE, TELEMOVEL, LASTLOGIN, ADMINISTRADOR, ESCRITA, LEITURA, ATIVO, VISIVEL)
SELECT 'CLINICOIMBRA', 'Ana Maria', 'clinicoimbra@gmail.com', 'Coimbra2011', '', '', '919939786', null, 1, 1, 1, 1, 1 



-- Criação da tabela das folhas de kms
IF OBJECT_ID('dbo.FOLHA_KMS', 'U') IS NOT NULL 
	DROP TABLE dbo.FOLHA_KMS;
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].FOLHA_KMS(
	FOLHA_KMSID [int] IDENTITY(1,1) NOT NULL,
	BENEFICIARIO_NOME VARCHAR(500) NOT NULL DEFAULT '',
	BENEFICIARIO_NIF VARCHAR(50) NOT NULL DEFAULT '*',
	VIATURA_MATRICULA VARCHAR(50) NOT NULL DEFAULT '',
	VIATURA_PROPRIETARIO VARCHAR(500) NOT NULL DEFAULT '',
	PRECO_KM DECIMAL(15,2) NOT NULL DEFAULT 0.00,
	MES INT NOT NULL DEFAULT MONTH(GETDATE()),
	ANO INT NOT NULL DEFAULT YEAR(GETDATE()),
	TOTAL_KMS DECIMAL(15,2) NOT NULL DEFAULT 0.00,
	TOTAL_RECEBIDO DECIMAL(15,2) NOT NULL DEFAULT 0.00,
	[CTRLDATA] [datetime] NOT NULL DEFAULT GETDATE(),
	[CTRLCODOP] [char](15) NOT NULL DEFAULT '*',
 CONSTRAINT [PK_FOLHA_KMS] PRIMARY KEY CLUSTERED 
(
	[FOLHA_KMSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [IX_FOLHA_KMS_BENEFICIARIO_MES_ANO] UNIQUE NONCLUSTERED 
(
	[BENEFICIARIO_NIF] ASC,
	MES ASC,
	ANO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


-- Criação da tabela das folhas de kms
IF OBJECT_ID('dbo.FOLHA_KMS_LN', 'U') IS NOT NULL 
	DROP TABLE dbo.FOLHA_KMS_LN;
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].FOLHA_KMS_LN(
	FOLHA_KMS_LNID [int] IDENTITY(1,1) NOT NULL,
	ID_FOLHA_KMS int NOT NULL REFERENCES FOLHA_KMS(FOLHA_KMSID),
	DATA_KMS DATE NOT NULL DEFAULT GETDATE(),
	HORA_PARTIDA TIME NOT NULL DEFAULT GETDATE(),
	HORA_CHEGADA TIME NOT NULL DEFAULT GETDATE(),
	DESTINO VARCHAR(MAX) NOT NULL DEFAULT '',
	KMS DECIMAL(15,2) NOT NULL DEFAULT 0.00,
	CUSTO DECIMAL(15,2) NOT NULL DEFAULT 0.00,
	NOTAS VARCHAR(MAX) NOT NULL DEFAULT '',
	[CTRLDATA] [datetime] NOT NULL DEFAULT GETDATE(),
	[CTRLCODOP] [char](15) NOT NULL DEFAULT '*',
 CONSTRAINT [PK_FOLHA_KMS_LN] PRIMARY KEY CLUSTERED 
(
	[FOLHA_KMS_LNID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [IX_FOLHA_KMS_LN_IDFOLHA_DATA_HORA] UNIQUE NONCLUSTERED 
(
	ID_FOLHA_KMS ASC,
	DATA_KMS ASC,
	HORA_PARTIDA ASC,
	HORA_CHEGADA ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

alter table folha_kms_ln
add origem varchar(max) NOT NULL DEFAULT ''


-- Criação da tabela das folhas de kms
IF OBJECT_ID('dbo.ESPECIALIDADES', 'U') IS NOT NULL 
	DROP TABLE dbo.ESPECIALIDADES;
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].ESPECIALIDADES(
	ESPECIALIDADESID [int] IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(500) NOT NULL DEFAULT '',
	ID_MEDICO INT NULL REFERENCES MEDICOS(MEDICOSID),
	HORARIO VARCHAR(500) NOT NULL DEFAULT '',
	NOTAS VARCHAR(MAX) NOT NULL DEFAULT '',
	FOTO VARCHAR(500) NOT NULL DEFAULT '',
	[CTRLDATA] [datetime] NOT NULL DEFAULT GETDATE(),
	[CTRLCODOP] [char](15) NOT NULL DEFAULT '*',
 CONSTRAINT [PK_ESPECIALIDADES] PRIMARY KEY CLUSTERED 
(
	[ESPECIALIDADESID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [IX_ESPECIALIDADES] UNIQUE NONCLUSTERED 
(
	NOME ASC,
	ID_MEDICO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go


INSERT INTO ESPECIALIDADES(NOME, ID_MEDICO, HORARIO, CLINICA, NOTAS, FOTO)
SELECT 'Acupuntura Regulamentada', medicosid, 'Por marcação', '', '', 'acupuntura.jpg'
from medicos
where nome = 'Dr. José Gândara'
union
SELECT 'Cardiologia', medicosid, '4ª - 15:30-19:30', '', '', 'cardiologia.jpg'
from medicos
where nome = 'Dr. Domingos Ramos'
union
SELECT 'Endocrinologia', medicosid, '3ª - 18:00-19:30', '', '', 'endocrionologia.jpg'
from medicos
where nome = 'Dra. Jacinta Santos'
union
SELECT 'Flebologia', medicosid, '4ª - 10:00-18:30', 'Clínica de Flebologia Dra. Fernanda Ribeirinho', '', 'flebologia.jpg'
from medicos
where nome = 'Dra. Fernanda Ribeirinho'
union
SELECT 'Ginecologia / Obstetrícia', medicosid, '3ª - 15:30-19:00', 'ERAGIN Ginecologia e Obstetrícia Lda', 'Ocasionalmente às 6ª - 15:30-19:00', 'ginecologia_obstetricia.jpg'
from medicos
where nome = 'Dra. Elisabeth Castelo Branco'
union
SELECT 'Neurologia', medicosid, '3ª - 15:00-19:00', '', '', 'neurologia.jpg'
from medicos
where nome = 'Dr. António Mestre'
union
SELECT 'Nutrição', medicosid, 'Por Marcação', '', '', 'nutricao.jpg'
from medicos
where nome = 'Dra. Paula Silva'
union
SELECT 'Oftalmologia', medicosid, '2ª - 16:00-20:00', 'Clínica Oftalmológica Dr. Mário Alfaiate Lda', '', 'oftalmologia.jpg'
from medicos
where nome = 'Dr. Mário Alfaiate'
union
SELECT 'Ortopedia', medicosid, '4ª - 14:30-19:00', 'R.M.V.C. Ortopedia Lda', '', 'ortopedia.jpg'
from medicos
where nome = 'Dr. Rui Cabral'
union
SELECT 'Otorrinolaringologia', medicosid, '3ª - 15:30-19:30', '', '', 'otorrino.jpg'
from medicos
where nome = 'Dr. Jorge Migueis'
union
SELECT 'Psiquiatria', medicosid, '2ª - 15:00-19:30', '', '', 'psiquiatria.png'
from medicos
where nome = 'Dra. Laura Nascimento'
union
SELECT 'Psicologia Clínica', NULL, 'Por marcação', '', '', 'psicologia.png'
from medicos
where nome = 'Dra. Maria João Martins'
union
SELECT 'Reumatologia', medicosid, '2ª - 16:30-19:30 (quinzenalmente)', '', '', 'reumatologia.jpg'
from medicos
where nome = 'Dra. Cátia Duarte'


-- Criação da tabela das sessões dos operadores
IF OBJECT_ID('dbo.OPERADORES_SESSAO', 'U') IS NOT NULL 
	DROP TABLE dbo.OPERADORES_SESSAO;
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OPERADORES_SESSAO](
	[OPERADORES_SESSAOID] [int] IDENTITY(1,1) NOT NULL,
	[ID_OP] [int] NOT NULL REFERENCES OPERADORES(OPERADORESID),
	[DATA_INICIO] DATETIME NOT NULL DEFAULT GETDATE(),
	[DATA_FIM] DATETIME NULL,
 CONSTRAINT [PK_OPERADORES_SESSAO] PRIMARY KEY CLUSTERED 
(
	[OPERADORES_SESSAOID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [IX_OPERADORES_SESSAO_VALIDADE] UNIQUE NONCLUSTERED 
(
	[ID_OP] ASC,
	[DATA_INICIO] ASC,
	[DATA_FIM] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CRIA_SESSAO]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [CRIA_SESSAO]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[CRIA_SESSAO]
	@id_operador int,
	@ret int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy;
    
    SET @ret = 0;
    
    IF(select codigo from operadores where operadoresid = @id_operador) IS NOT NULL
    begin
	insert into operadores_sessao(id_op, data_inicio, data_fim)
	select @id_operador, getdate(), null
	
	set @ret = scope_identity();
    end
    else
    begin
	set @ret = -1;
    end
    
    COMMIT;
    RETURN;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @ret = -999;
	RETURN;
    END CATCH;	
end

GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TERMINA_SESSAO]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [TERMINA_SESSAO]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[TERMINA_SESSAO]
	@id_sessao int,
	@ret int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy;
    
    SET @ret = 0;
    
    IF(select OPERADORES_SESSAOID from operadores_sessao where operadores_sessaoid = @id_sessao) IS NOT NULL
    begin
	update operadores_sessao
	set data_fim = getdate()
	where operadores_sessaoid = @id_sessao
	
	set @ret = @id_sessao;
    end
    else
    begin
	set @ret = -1;
    end
    
    COMMIT;
    RETURN;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @ret = -999;
	RETURN;
    END CATCH;	
end

GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[LOGIN]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [LOGIN]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[LOGIN]
	@user char(30),
	@pass varchar(60),
	@ret int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy;
    
    SET @ret = 0;
	declare @id_operador int = (select operadoresid from operadores where ltrim(rtrim(codigo)) = @user and ltrim(rtrim(password)) = @pass)
    
    IF @id_operador IS NOT NULL
    begin
		exec CRIA_SESSAO @id_operador, @ret output
    end
    else
    begin
		set @ret = -1;
    end
    
    COMMIT;
    RETURN;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @ret = -999;
	RETURN;
    END CATCH;	
end

GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[LOGOUT]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [LOGOUT]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[LOGOUT]
	@id_sessao int,
	@ret int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy;
    
    SET @ret = 0;
    
    EXEC TERMINA_SESSAO @id_sessao, @ret output
    
    COMMIT;
    RETURN;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @ret = -999;
	RETURN;
    END CATCH;	
end

GO


-- Criação da tabela das folhas de kms
IF OBJECT_ID('dbo.CLIENTES', 'U') IS NOT NULL 
	DROP TABLE dbo.CLIENTES;
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].CLIENTES(
	CLIENTESID [int] IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(500) NOT NULL DEFAULT '',
	DATA_NASCIMENTO DATETIME NOT NULL DEFAULT GETDATE(),
	CC_NR VARCHAR(100) NOT NULL DEFAULT '',
	NIF VARCHAR(100) NOT NULL DEFAULT '',
	PROFISSAO VARCHAR(500) NOT NULL DEFAULT '',
	ESTADO_CIVIL VARCHAR(250) NOT NULL DEFAULT '',
	NATURALIDADE VARCHAR(250) NOT NULL DEFAULT '',
	MORADA VARCHAR(500) NOT NULL DEFAULT '',
	TELEFONE VARCHAR(250) NOT NULL DEFAULT '',
	DIAGNOSTICO VARCHAR(MAX) NOT NULL DEFAULT '',
	NOTAS VARCHAR(MAX) NOT NULL DEFAULT '',
	[CTRLDATA] [datetime] NOT NULL DEFAULT GETDATE(),
	[CTRLCODOP] [char](15) NOT NULL DEFAULT '*',
 CONSTRAINT [PK_CLIENTES] PRIMARY KEY CLUSTERED 
(
	[CLIENTESID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [IX_CLIENTES_CODIGO] UNIQUE NONCLUSTERED 
(
	NOME ASC,
	NIF ASC,
	CC_NR ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go




alter PROCEDURE [dbo].[CRIA_FOLHA_KMS](
      @id_op int
	, @DocXml nvarchar(max)	
    , @erro int OUTPUT
)
AS BEGIN
	set dateformat dmy  
    SET @erro = 0
	
	DECLARE @DocHandle INT; SET @DocHandle=-1;
	DECLARE @XmlDocument VARCHAR(MAX);
	DECLARE @codOp char(30) = (select codigo from operadores where operadoresid = @id_op);

	DECLARE @BENEFICIARIO_NOME VARCHAR(500)
	DECLARE @BENEFICIARIO_NIF VARCHAR(50)
	DECLARE @VIATURA_MATRICULA VARCHAR(50)
	DECLARE @VIATURA_PROPRIETARIO VARCHAR(500)
	DECLARE @PRECO_KM DECIMAL(15,2)
	DECLARE @MES INT
	DECLARE @ANO INT
	DECLARE @TOTAL_KMS DECIMAL(15,2)
	DECLARE @TOTAL_RECEBIDO DECIMAL(15,2)

	DECLARE @ln table 
	(
		DATA_KMS INT NOT NULL,
		HORA_PARTIDA TIME NOT NULL,
		HORA_CHEGADA TIME NOT NULL,
		DESTINO VARCHAR(MAX) NOT NULL,
		KMS DECIMAL(15,2) NOT NULL,
		CUSTO DECIMAL(15,2) NOT NULL,
		NOTAS VARCHAR(MAX) NOT NULL,
		ORIGEM VARCHAR(MAX) NOT NULL
	)

	-- START
	SET @XmlDocument=@DocXml;
	EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DocXml;

	-- OBTEMOS OS DADOS DA CABEÇA
	SELECT 
		@BENEFICIARIO_NOME = BENEFICIARIO_NOME,
		@BENEFICIARIO_NIF = BENEFICIARIO_NIF,
		@VIATURA_MATRICULA = VIATURA_MATRICULA,
		@VIATURA_PROPRIETARIO = VIATURA_PROPRIETARIO,
		@PRECO_KM = PRECO_KM,
		@MES = MES,
		@ANO = ANO,
		@TOTAL_KMS = TOTAL_KMS,
		@TOTAL_RECEBIDO = TOTAL_RECEBIDO 
	FROM OPENXML (@DocHandle, '/FOLHA',2)
	WITH (BENEFICIARIO_NOME VARCHAR(500),
		BENEFICIARIO_NIF VARCHAR(50),
		VIATURA_MATRICULA VARCHAR(50),
		VIATURA_PROPRIETARIO VARCHAR(500),
		PRECO_KM DECIMAL(15,2),
		MES INT,
		ANO INT,
		TOTAL_KMS DECIMAL(15,2),
		TOTAL_RECEBIDO DECIMAL(15,2)) FOLHA

	-- OBTEMOS AS LINHAS A TRATAR
	INSERT INTO @ln (DATA_KMS,HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,ORIGEM)
	SELECT DATA_KMS,HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,ORIGEM
	FROM OPENXML (@DocHandle, '/FOLHA/FOLHA_LN',2)
	WITH (DATA_KMS INT,
		HORA_PARTIDA TIME,
		HORA_CHEGADA TIME,
		DESTINO VARCHAR(MAX),
		KMS DECIMAL(15,2),
		CUSTO DECIMAL(15,2),
		NOTAS VARCHAR(MAX),
		ORIGEM VARCHAR(MAX)) FOLHA_LN

	INSERT INTO FOLHA_KMS(BENEFICIARIO_NOME,BENEFICIARIO_NIF,VIATURA_MATRICULA,VIATURA_PROPRIETARIO,PRECO_KM,MES,ANO,TOTAL_KMS,TOTAL_RECEBIDO,CTRLCODOP)
	select @BENEFICIARIO_NOME,@BENEFICIARIO_NIF,@VIATURA_MATRICULA,@VIATURA_PROPRIETARIO,@PRECO_KM,@MES,@ANO,@TOTAL_KMS,@TOTAL_RECEBIDO,@codOp

	set @erro = scope_identity();

	INSERT INTO FOLHA_KMS_LN(ID_FOLHA_KMS,DATA_KMS,HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,CTRLCODOP,ORIGEM)
	select @erro,
		(CASE WHEN DATA_KMS < 9 THEN '0' ELSE '' END) + LTRIM(RTRIM(STR(DATA_KMS))) + '-' 
		+ (CASE WHEN @MES < 9 THEN '0' ELSE '' END) + LTRIM(RTRIM(STR(@MES))) + '-'
		+ LTRIM(RTRIM(STR(@ANO))),
		HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,@codOp,ORIGEM
	from @ln ln

	return;
END; 


GO


create PROCEDURE [dbo].[EDITA_FOLHA_KMS](
      @id_op int
	, @DocXml nvarchar(max)	
    , @erro int OUTPUT
)
AS BEGIN
	set dateformat dmy  
    SET @erro = 0
	
	DECLARE @DocHandle INT; SET @DocHandle=-1;
	DECLARE @XmlDocument VARCHAR(MAX);
	DECLARE @codOp char(30) = (select codigo from operadores where operadoresid = @id_op);

	DECLARE @ID_FOLHA INT
	DECLARE @BENEFICIARIO_NOME VARCHAR(500)
	DECLARE @BENEFICIARIO_NIF VARCHAR(50)
	DECLARE @VIATURA_MATRICULA VARCHAR(50)
	DECLARE @VIATURA_PROPRIETARIO VARCHAR(500)
	DECLARE @PRECO_KM DECIMAL(15,2)
	DECLARE @MES INT
	DECLARE @ANO INT
	DECLARE @TOTAL_KMS DECIMAL(15,2)
	DECLARE @TOTAL_RECEBIDO DECIMAL(15,2)

	DECLARE @ln table 
	(
		DATA_KMS INT NOT NULL,
		HORA_PARTIDA TIME NOT NULL,
		HORA_CHEGADA TIME NOT NULL,
		DESTINO VARCHAR(MAX) NOT NULL,
		KMS DECIMAL(15,2) NOT NULL,
		CUSTO DECIMAL(15,2) NOT NULL,
		NOTAS VARCHAR(MAX) NOT NULL,
		ORIGEM VARCHAR(MAX) NOT NULL
	)

	-- START
	SET @XmlDocument=@DocXml;
	EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DocXml;

	-- OBTEMOS OS DADOS DA CABEÇA
	SELECT
		@ID_FOLHA = ID_FOLHA,
		@BENEFICIARIO_NOME = BENEFICIARIO_NOME,
		@BENEFICIARIO_NIF = BENEFICIARIO_NIF,
		@VIATURA_MATRICULA = VIATURA_MATRICULA,
		@VIATURA_PROPRIETARIO = VIATURA_PROPRIETARIO,
		@PRECO_KM = PRECO_KM,
		@MES = MES,
		@ANO = ANO,
		@TOTAL_KMS = TOTAL_KMS,
		@TOTAL_RECEBIDO = TOTAL_RECEBIDO 
	FROM OPENXML (@DocHandle, '/FOLHA',2)
	WITH (ID_FOLHA INT,
		BENEFICIARIO_NOME VARCHAR(500),
		BENEFICIARIO_NIF VARCHAR(50),
		VIATURA_MATRICULA VARCHAR(50),
		VIATURA_PROPRIETARIO VARCHAR(500),
		PRECO_KM DECIMAL(15,2),
		MES INT,
		ANO INT,
		TOTAL_KMS DECIMAL(15,2),
		TOTAL_RECEBIDO DECIMAL(15,2)) FOLHA

	-- OBTEMOS AS LINHAS A TRATAR
	INSERT INTO @ln (DATA_KMS,HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,ORIGEM)
	SELECT DATA_KMS,HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,ORIGEM
	FROM OPENXML (@DocHandle, '/FOLHA/FOLHA_LN',2)
	WITH (DATA_KMS INT,
		HORA_PARTIDA TIME,
		HORA_CHEGADA TIME,
		DESTINO VARCHAR(MAX),
		KMS DECIMAL(15,2),
		CUSTO DECIMAL(15,2),
		NOTAS VARCHAR(MAX),
		ORIGEM VARCHAR(MAX)) FOLHA_LN

	UPDATE FOLHA_KMS
	SET BENEFICIARIO_NOME = @BENEFICIARIO_NOME,
	BENEFICIARIO_NIF = @BENEFICIARIO_NIF,
	VIATURA_MATRICULA = @VIATURA_MATRICULA,
	VIATURA_PROPRIETARIO = @VIATURA_PROPRIETARIO,
	PRECO_KM = @PRECO_KM,
	MES = @MES,
	ANO = @ANO,
	TOTAL_KMS = @TOTAL_KMS,
	TOTAL_RECEBIDO = @TOTAL_RECEBIDO,
	CTRLCODOP = @codOp
	WHERE FOLHA_KMSID = @ID_FOLHA

	DELETE FROM FOLHA_KMS_LN WHERE ID_FOLHA_KMS = @ID_FOLHA

	INSERT INTO FOLHA_KMS_LN(ID_FOLHA_KMS,DATA_KMS,HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,CTRLCODOP,ORIGEM)
	select @erro,
		(CASE WHEN DATA_KMS < 9 THEN '0' ELSE '' END) + LTRIM(RTRIM(STR(DATA_KMS))) + '-' 
		+ (CASE WHEN @MES < 9 THEN '0' ELSE '' END) + LTRIM(RTRIM(STR(@MES))) + '-'
		+ LTRIM(RTRIM(STR(@ANO))),
		HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,@codOp,ORIGEM
	from @ln ln  

	return;
END; 


GO


alter PROCEDURE [dbo].[EDITA_FOLHA_KMS](
      @id_op int
	, @DocXml nvarchar(max)	
    , @erro int OUTPUT
)
AS BEGIN
	set dateformat dmy  
    SET @erro = 0
	
	DECLARE @DocHandle INT; SET @DocHandle=-1;
	DECLARE @XmlDocument VARCHAR(MAX);
	DECLARE @codOp char(30) = (select codigo from operadores where operadoresid = @id_op);

	DECLARE @ID_FOLHA INT
	DECLARE @BENEFICIARIO_NOME VARCHAR(500)
	DECLARE @BENEFICIARIO_NIF VARCHAR(50)
	DECLARE @VIATURA_MATRICULA VARCHAR(50)
	DECLARE @VIATURA_PROPRIETARIO VARCHAR(500)
	DECLARE @PRECO_KM DECIMAL(15,2)
	DECLARE @MES INT
	DECLARE @ANO INT
	DECLARE @TOTAL_KMS DECIMAL(15,2)
	DECLARE @TOTAL_RECEBIDO DECIMAL(15,2)

	DECLARE @ln table 
	(
		DATA_KMS INT NOT NULL,
		HORA_PARTIDA TIME NOT NULL,
		HORA_CHEGADA TIME NOT NULL,
		DESTINO VARCHAR(MAX) NOT NULL,
		KMS DECIMAL(15,2) NOT NULL,
		CUSTO DECIMAL(15,2) NOT NULL,
		NOTAS VARCHAR(MAX) NOT NULL,
		ORIGEM VARCHAR(MAX) NOT NULL
	)

	-- START
	SET @XmlDocument=@DocXml;
	EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DocXml;

	-- OBTEMOS OS DADOS DA CABEÇA
	SELECT
		@ID_FOLHA = ID_FOLHA,
		@BENEFICIARIO_NOME = BENEFICIARIO_NOME,
		@BENEFICIARIO_NIF = BENEFICIARIO_NIF,
		@VIATURA_MATRICULA = VIATURA_MATRICULA,
		@VIATURA_PROPRIETARIO = VIATURA_PROPRIETARIO,
		@PRECO_KM = PRECO_KM,
		@MES = MES,
		@ANO = ANO,
		@TOTAL_KMS = TOTAL_KMS,
		@TOTAL_RECEBIDO = TOTAL_RECEBIDO 
	FROM OPENXML (@DocHandle, '/FOLHA',2)
	WITH (ID_FOLHA INT,
		BENEFICIARIO_NOME VARCHAR(500),
		BENEFICIARIO_NIF VARCHAR(50),
		VIATURA_MATRICULA VARCHAR(50),
		VIATURA_PROPRIETARIO VARCHAR(500),
		PRECO_KM DECIMAL(15,2),
		MES INT,
		ANO INT,
		TOTAL_KMS DECIMAL(15,2),
		TOTAL_RECEBIDO DECIMAL(15,2)) FOLHA

	-- OBTEMOS AS LINHAS A TRATAR
	INSERT INTO @ln (DATA_KMS,HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,ORIGEM)
	SELECT DATA_KMS,HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,ORIGEM
	FROM OPENXML (@DocHandle, '/FOLHA/FOLHA_LN',2)
	WITH (DATA_KMS INT,
		HORA_PARTIDA TIME,
		HORA_CHEGADA TIME,
		DESTINO VARCHAR(MAX),
		KMS DECIMAL(15,2),
		CUSTO DECIMAL(15,2),
		NOTAS VARCHAR(MAX),
		ORIGEM VARCHAR(MAX)) FOLHA_LN

	UPDATE FOLHA_KMS
	SET BENEFICIARIO_NOME = @BENEFICIARIO_NOME,
	BENEFICIARIO_NIF = @BENEFICIARIO_NIF,
	VIATURA_MATRICULA = @VIATURA_MATRICULA,
	VIATURA_PROPRIETARIO = @VIATURA_PROPRIETARIO,
	PRECO_KM = @PRECO_KM,
	MES = @MES,
	ANO = @ANO,
	TOTAL_KMS = @TOTAL_KMS,
	TOTAL_RECEBIDO = @TOTAL_RECEBIDO,
	CTRLCODOP = @codOp
	WHERE FOLHA_KMSID = @ID_FOLHA

	DELETE FROM FOLHA_KMS_LN WHERE ID_FOLHA_KMS = @ID_FOLHA

	INSERT INTO FOLHA_KMS_LN(ID_FOLHA_KMS,DATA_KMS,HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,CTRLCODOP,ORIGEM)
	select @ID_FOLHA,
		(CASE WHEN DATA_KMS < 9 THEN '0' ELSE '' END) + LTRIM(RTRIM(STR(DATA_KMS))) + '-' 
		+ (CASE WHEN @MES < 9 THEN '0' ELSE '' END) + LTRIM(RTRIM(STR(@MES))) + '-'
		+ LTRIM(RTRIM(STR(@ANO))),
		HORA_PARTIDA,HORA_CHEGADA,DESTINO,KMS,CUSTO,NOTAS,@codOp,ORIGEM
	from @ln ln  

	return;
END; 


GO


-- Criação da tabela dos médicos
IF OBJECT_ID('dbo.MEDICOS', 'U') IS NOT NULL 
	DROP TABLE dbo.MEDICOS;
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].MEDICOS(
	MEDICOSID [int] IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(500) NOT NULL DEFAULT '',
	NOTAS VARCHAR(MAX) NOT NULL DEFAULT '',
	[CTRLDATA] [datetime] NOT NULL DEFAULT GETDATE(),
	[CTRLCODOP] [char](15) NOT NULL DEFAULT '*',
 CONSTRAINT [PK_MEDICOS] PRIMARY KEY CLUSTERED 
(
	[MEDICOSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [IX_MEDICOS_NOME] UNIQUE NONCLUSTERED 
(
	NOME ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

ALTER TABLE MEDICOS
ADD CLINICA VARCHAR(500) NOT NULL DEFAULT ''

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REPORT_MEDICOS_ESPECIALIDADES]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].REPORT_MEDICOS_ESPECIALIDADES
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_MEDICOS_ESPECIALIDADES](@id_medico int, @id_especialidade int)
returns table as return
(
	select
	    spec.ESPECIALIDADESID as id_especialidade,
		spec.nome as especialidade,
		spec.horario,
		spec.notas as notas_especialidade,
		spec.foto,
		isnull(med.MEDICOSID, 0) as id_medico,
		isnull(med.nome, '') as medico,
		isnull(med.notas, '') as notas_medico,
		isnull(med.clinica, '') as clinica
	from especialidades spec
	left join medicos med on med.medicosid = spec.id_medico
	where (@id_medico is null or @id_medico = med.medicosid)
	and (@id_especialidade is null or @id_especialidade = spec.especialidadesid)
)
GO


-- Criação da tabela das consultas
IF OBJECT_ID('dbo.CONSULTAS', 'U') IS NOT NULL 
	DROP TABLE dbo.CONSULTAS;
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].CONSULTAS(
	CONSULTASID [int] IDENTITY(1,1) NOT NULL,
	ID_CLIENTE int NOT NULL REFERENCES CLIENTES(CLIENTESID),
	ID_MEDICO INT NOT NULL REFERENCES MEDICOS(MEDICOSID),
	ID_ESPECIALIDADE INT NOT NULL REFERENCES ESPECIALIDADES(ESPECIALIDADESID),
	[DATA] DATETIME NOT NULL DEFAULT '',
	DESCRICAO VARCHAR(MAX) NOT NULL DEFAULT '',
	[CTRLDATA] [datetime] NOT NULL DEFAULT GETDATE(),
	[CTRLCODOP] [char](15) NOT NULL DEFAULT '*',
 CONSTRAINT [PK_CONSULTAS] PRIMARY KEY CLUSTERED 
(
	[CONSULTASID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [IX_CONSULTAS] UNIQUE NONCLUSTERED 
(
	ID_CLIENTE ASC,
	ID_MEDICO ASC,
	ID_ESPECIALIDADE ASC,
	[DATA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REPORT_MEDICOS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].REPORT_MEDICOS
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_MEDICOS](@id_medico int)
returns table as return
(
	select
	    med.MEDICOSID as id_medico,
		med.nome as medico,
		med.notas,
		med.clinica,
		isnull(spec.especialidadesid, 0) as id_especialidade,
		isnull(spec.nome, '') as especialidade	
	from medicos med
	left join ESPECIALIDADES spec on med.medicosid = spec.id_medico
	where (@id_medico is null or @id_medico = med.medicosid)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CRIA_MEDICO]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [CRIA_MEDICO]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[CRIA_MEDICO]
	@id_operador int,
	@nome varchar(500),
	@notas varchar(max),
	@clinica varchar(500),
	@res int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy
		
    declare @operatorcode char(30)
		
    select @operatorcode = LTRIM(RTRIM(codigo)) from operadores where operadoresid = @id_operador
		
    if(@operatorcode is null)
    begin
		set @res = -1;
		COMMIT;
		return;
    end
    
    INSERT INTO MEDICOS(NOME, NOTAS, CLINICA)
	SELECT @nome, @notas, @clinica

	set @res = SCOPE_IDENTITY();

	COMMIT;
	return;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @res = -1;
	RETURN;
    END CATCH;	
end
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ALTERA_MEDICO]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [ALTERA_MEDICO]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[ALTERA_MEDICO]
	@id_operador int,
	@id_medico int,
	@nome varchar(500),
	@notas varchar(max),
	@clinica varchar(500),
	@res int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy
		
    declare @operatorcode char(30)
		
    select @operatorcode = LTRIM(RTRIM(codigo)) from operadores where operadoresid = @id_operador
		
    if(@operatorcode is null)
    begin
		set @res = -1;
		COMMIT;
		return;
    end

	if(select medicosid from medicos where medicosid = @id_medico) is null
	begin
		set @res = -2;
		COMMIT;
		return;
	end
    
    UPDATE MEDICOS
	set nome = @nome, notas = @notas, clinica = @clinica
	where medicosid = @id_medico

	set @res = 0;

    COMMIT;
	return;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @res = -1;
	RETURN;
    END CATCH;	
end
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[APAGA_MEDICO]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [APAGA_MEDICO]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[APAGA_MEDICO]
	@id_operador int,
	@id_medico int,
	@res int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy
		
    declare @operatorcode char(30)
		
    select @operatorcode = LTRIM(RTRIM(codigo)) from operadores where operadoresid = @id_operador
		
    if(@operatorcode is null)
    begin
		set @res = -1;
		COMMIT;
		return;
    end

	if(select medicosid from medicos where medicosid = @id_medico) is null
	begin
		set @res = -2;
		COMMIT;
		return;
	end
    
    DELETE FROM MEDICOS
	where medicosid = @id_medico

	set @res = 0;

    COMMIT;
	return;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @res = -1;
	RETURN;
    END CATCH;	
end
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REPORT_CLIENTES]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].REPORT_CLIENTES
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_CLIENTES](@id_cliente int)
returns table as return
(
	select
	    clientesid as id_cliente,
		nome,
		data_nascimento,
		cc_nr,
		nif,
		profissao,
		estado_civil,
		naturalidade,
		morada,
		telefone,
		diagnostico,
		notas	
	from clientes
	where (@id_cliente is null or @id_cliente = clientesid)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CRIA_CLIENTE]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [CRIA_CLIENTE]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[CRIA_CLIENTE]
	@id_operador int,
	@nome varchar(500),
	@data_nascimento DATETIME,
	@cc_nr VARCHAR(100),
	@nif VARCHAR(100),
	@profissao VARCHAR(500),
	@estado_civil VARCHAR(250),
	@naturalidade VARCHAR(250),
	@morada VARCHAR(500),
	@telefone VARCHAR(250),
	@diagnostico VARCHAR(MAX),
	@notas varchar(max),
	@res int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy
		
    declare @operatorcode char(30)
		
    select @operatorcode = LTRIM(RTRIM(codigo)) from operadores where operadoresid = @id_operador
		
    if(@operatorcode is null)
    begin
		set @res = -1;
		COMMIT;
		return;
    end
    
    INSERT INTO CLIENTES(NOME, DATA_NASCIMENTO, CC_NR, NIF, PROFISSAO, ESTADO_CIVIL, NATURALIDADE, MORADA, TELEFONE, DIAGNOSTICO, NOTAS)
	select @nome, @data_nascimento, @cc_nr, @nif, @profissao, @estado_civil, @naturalidade, @morada, @telefone, @diagnostico, @notas

	set @res = SCOPE_IDENTITY();

	COMMIT;
	return;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @res = -1;
	RETURN;
    END CATCH;	
end
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ALTERA_CLIENTE]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [ALTERA_CLIENTE]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[ALTERA_CLIENTE]
	@id_operador int,
	@id_cliente int,
	@nome varchar(500),
	@data_nascimento DATETIME,
	@cc_nr VARCHAR(100),
	@nif VARCHAR(100),
	@profissao VARCHAR(500),
	@estado_civil VARCHAR(250),
	@naturalidade VARCHAR(250),
	@morada VARCHAR(500),
	@telefone VARCHAR(250),
	@diagnostico VARCHAR(MAX),
	@notas varchar(max),
	@res int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy
		
    declare @operatorcode char(30)
		
    select @operatorcode = LTRIM(RTRIM(codigo)) from operadores where operadoresid = @id_operador
		
    if(@operatorcode is null)
    begin
		set @res = -1;
		COMMIT;
		return;
    end

	if(select clientesid from clientes where CLIENTESID = @id_cliente) is null
	begin
		set @res = -2;
		COMMIT;
		return;
    end
    
    UPDATE CLIENTES
	SET NOME = @nome, DATA_NASCIMENTO = @data_nascimento, CC_NR = @cc_nr, 
	NIF = @nif, PROFISSAO = @profissao, ESTADO_CIVIL = @estado_civil, NATURALIDADE = @naturalidade, 
	MORADA = @morada, TELEFONE = @telefone, DIAGNOSTICO = @diagnostico, NOTAS = @notas
	where clientesid = @id_cliente

	set @res = 0;

	COMMIT;
	return;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @res = -1;
	RETURN;
    END CATCH;	
end
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[APAGA_CLIENTE]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [APAGA_CLIENTE]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[APAGA_CLIENTE]
	@id_operador int,
	@id_cliente int,
	@res int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy
		
    declare @operatorcode char(30)
		
    select @operatorcode = LTRIM(RTRIM(codigo)) from operadores where operadoresid = @id_operador
		
    if(@operatorcode is null)
    begin
		set @res = -1;
		COMMIT;
		return;
    end

	if(select clientesid from clientes where clientesid = @id_cliente) is null
	begin
		set @res = -2;
		COMMIT;
		return;
	end
    
    DELETE FROM CLIENTES
	where clientesid = @id_cliente

	set @res = 0;

    COMMIT;
	return;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @res = -1;
	RETURN;
    END CATCH;	
end
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CRIA_ESPECIALIDADE]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [CRIA_ESPECIALIDADE]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[CRIA_ESPECIALIDADE]
	@id_operador int,
	@nome varchar(500),
	@id_medico int,
	@horario varchar(500),
	@foto VARCHAR(500),
	@notas varchar(max),
	@res int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy
		
    declare @operatorcode char(30)
		
    select @operatorcode = LTRIM(RTRIM(codigo)) from operadores where operadoresid = @id_operador
		
    if(@operatorcode is null)
    begin
		set @res = -1;
		COMMIT;
		return;
    end

	if(select nome from medicos where medicosid = @id_medico and isnull(@id_medico, 0) > 0) is null
	begin
		set @res = -2;
		COMMIT;
		return;
    end
    
    INSERT INTO ESPECIALIDADES(NOME, ID_MEDICO, HORARIO, NOTAS, FOTO)
	select @nome, case when @id_medico = 0 then null else @id_medico end, @horario, @notas, @foto

	set @res = SCOPE_IDENTITY();

	COMMIT;
	return;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @res = -1;
	RETURN;
    END CATCH;	
end
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ALTERA_ESPECIALIDADE]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [ALTERA_ESPECIALIDADE]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[ALTERA_ESPECIALIDADE]
	@id_operador int,
	@id_especialidade int,
	@nome varchar(500),
	@id_medico int,
	@horario varchar(500),
	@foto VARCHAR(500),
	@notas varchar(max),
	@res int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy
		
    declare @operatorcode char(30)
		
    select @operatorcode = LTRIM(RTRIM(codigo)) from operadores where operadoresid = @id_operador
		
    if(@operatorcode is null)
    begin
		set @res = -1;
		COMMIT;
		return;
    end

	if(select nome from medicos where medicosid = @id_medico and isnull(@id_medico, 0) > 0) is null
	begin
		set @res = -2;
		COMMIT;
		return;
    end

	IF(@id_medico = 0)
	begin
		set @id_medico = null;
	end
    
    UPDATE ESPECIALIDADES
	SET NOME = @nome, ID_MEDICO = @id_medico, HORARIO = @horario, 
	FOTO = @foto, NOTAS = @notas
	where ESPECIALIDADESID = @id_especialidade

	set @res = 0;

	COMMIT;
	return;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @res = -1;
	RETURN;
    END CATCH;	
end
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[APAGA_ESPECIALIDADE]') AND type IN (N'P', N'PC')) 
    DROP PROCEDURE [APAGA_ESPECIALIDADE]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================================
-- Author:		?
-- Description: ?
-- History:
--  (...)
-- =========================================================================
CREATE PROCEDURE [dbo].[APAGA_ESPECIALIDADE]
	@id_operador int,
	@id_especialidade int,
	@res int output
WITH RECOMPILE
AS 
begin
BEGIN TRY
    BEGIN TRANSACTION;
    set dateformat dmy
		
    declare @operatorcode char(30)
		
    select @operatorcode = LTRIM(RTRIM(codigo)) from operadores where operadoresid = @id_operador
		
    if(@operatorcode is null)
    begin
		set @res = -1;
		COMMIT;
		return;
    end

	if(select especialidadesid from especialidades where especialidadesid = @id_especialidade) is null
	begin
		set @res = -2;
		COMMIT;
		return;
	end
    
    DELETE FROM ESPECIALIDADES
	where especialidadesid = @id_especialidade

	set @res = 0;

    COMMIT;
	return;
END TRY
BEGIN CATCH 
    IF XACT_STATE() <> 0 OR @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;				
        set @res = -1;
	RETURN;
    END CATCH;	
end
GO
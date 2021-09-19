
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 09/18/2021 01:06:30
-- Generated from EDMX file: D:\FCIS\ASP.NET API Jquery\2\we task\we task\Models\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [task];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Access_Clients]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Accesses] DROP CONSTRAINT [FK_Access_Clients];
GO
IF OBJECT_ID(N'[dbo].[FK_ServiceOrders_Clients]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ServiceOrders] DROP CONSTRAINT [FK_ServiceOrders_Clients];
GO
IF OBJECT_ID(N'[dbo].[FK_Features_Services]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Features] DROP CONSTRAINT [FK_Features_Services];
GO
IF OBJECT_ID(N'[dbo].[FK_ServiceOrders_Features]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ServiceOrders] DROP CONSTRAINT [FK_ServiceOrders_Features];
GO
IF OBJECT_ID(N'[dbo].[FK_ServiceOrders_Services]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ServiceOrders] DROP CONSTRAINT [FK_ServiceOrders_Services];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Accesses]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Accesses];
GO
IF OBJECT_ID(N'[dbo].[Clients]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Clients];
GO
IF OBJECT_ID(N'[dbo].[Features]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Features];
GO
IF OBJECT_ID(N'[dbo].[ServiceOrders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ServiceOrders];
GO
IF OBJECT_ID(N'[dbo].[Services]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Services];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Accesses'
CREATE TABLE [dbo].[Accesses] (
    [id] int IDENTITY(1,1) NOT NULL,
    [ClientID] int  NOT NULL,
    [Service_1] bit  NOT NULL,
    [Service_2] bit  NOT NULL,
    [Service_3] bit  NOT NULL,
    [ContactNum] int  NULL
);
GO

-- Creating table 'Clients'
CREATE TABLE [dbo].[Clients] (
    [id] int IDENTITY(1,1) NOT NULL,
    [username] nvarchar(50)  NOT NULL,
    [password] nvarchar(50)  NOT NULL,
    [email] nvarchar(50)  NOT NULL,
    [token] nvarchar(50)  NOT NULL,
    [CreatedDate] datetime  NOT NULL,
    [UpdatedDate] datetime  NOT NULL
);
GO

-- Creating table 'Features'
CREATE TABLE [dbo].[Features] (
    [id] int IDENTITY(1,1) NOT NULL,
    [ServicesID] int  NOT NULL,
    [info] nvarchar(500)  NOT NULL
);
GO

-- Creating table 'ServiceOrders'
CREATE TABLE [dbo].[ServiceOrders] (
    [id] int IDENTITY(1,1) NOT NULL,
    [ClientID] int  NOT NULL,
    [ServiceID] int  NOT NULL,
    [FeatureID] int  NOT NULL,
    [Token] nvarchar(50)  NOT NULL,
    [OrderDate] datetime  NOT NULL,
    [Ordertype] nvarchar(50)  NOT NULL,
    [quantity] int  NOT NULL,
    [ContactNum] int  NULL
);
GO

-- Creating table 'Services'
CREATE TABLE [dbo].[Services] (
    [id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(50)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [id] in table 'Accesses'
ALTER TABLE [dbo].[Accesses]
ADD CONSTRAINT [PK_Accesses]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'Clients'
ALTER TABLE [dbo].[Clients]
ADD CONSTRAINT [PK_Clients]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'Features'
ALTER TABLE [dbo].[Features]
ADD CONSTRAINT [PK_Features]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'ServiceOrders'
ALTER TABLE [dbo].[ServiceOrders]
ADD CONSTRAINT [PK_ServiceOrders]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'Services'
ALTER TABLE [dbo].[Services]
ADD CONSTRAINT [PK_Services]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [ClientID] in table 'Accesses'
ALTER TABLE [dbo].[Accesses]
ADD CONSTRAINT [FK_Access_Clients]
    FOREIGN KEY ([ClientID])
    REFERENCES [dbo].[Clients]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Access_Clients'
CREATE INDEX [IX_FK_Access_Clients]
ON [dbo].[Accesses]
    ([ClientID]);
GO

-- Creating foreign key on [ClientID] in table 'ServiceOrders'
ALTER TABLE [dbo].[ServiceOrders]
ADD CONSTRAINT [FK_ServiceOrders_Clients]
    FOREIGN KEY ([ClientID])
    REFERENCES [dbo].[Clients]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ServiceOrders_Clients'
CREATE INDEX [IX_FK_ServiceOrders_Clients]
ON [dbo].[ServiceOrders]
    ([ClientID]);
GO

-- Creating foreign key on [ServicesID] in table 'Features'
ALTER TABLE [dbo].[Features]
ADD CONSTRAINT [FK_Features_Services]
    FOREIGN KEY ([ServicesID])
    REFERENCES [dbo].[Services]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Features_Services'
CREATE INDEX [IX_FK_Features_Services]
ON [dbo].[Features]
    ([ServicesID]);
GO

-- Creating foreign key on [FeatureID] in table 'ServiceOrders'
ALTER TABLE [dbo].[ServiceOrders]
ADD CONSTRAINT [FK_ServiceOrders_Features]
    FOREIGN KEY ([FeatureID])
    REFERENCES [dbo].[Features]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ServiceOrders_Features'
CREATE INDEX [IX_FK_ServiceOrders_Features]
ON [dbo].[ServiceOrders]
    ([FeatureID]);
GO

-- Creating foreign key on [ServiceID] in table 'ServiceOrders'
ALTER TABLE [dbo].[ServiceOrders]
ADD CONSTRAINT [FK_ServiceOrders_Services]
    FOREIGN KEY ([ServiceID])
    REFERENCES [dbo].[Services]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ServiceOrders_Services'
CREATE INDEX [IX_FK_ServiceOrders_Services]
ON [dbo].[ServiceOrders]
    ([ServiceID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------
USE [WEBAPP]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================================================
-- WEBAPP Database - Example tables for the generic skeleton
-- =============================================================================

CREATE TABLE [dbo].[products](
	[pr_id] [int] IDENTITY(1,1) NOT NULL,
	[pr_name] [nvarchar](100) NOT NULL,
	[pr_code] [nvarchar](30) NOT NULL,
	[pr_price] [decimal](12, 2) NOT NULL DEFAULT 0,
	[pr_cost] [decimal](12, 2) NOT NULL DEFAULT 0,
	[pr_category] [nvarchar](50) NOT NULL DEFAULT '',
	[pr_unit] [nvarchar](20) NOT NULL DEFAULT 'Each',
	[pr_active] [bit] NOT NULL DEFAULT 1,
	[pr_notes] [nvarchar](max) NOT NULL DEFAULT '',
	[pr_created] [datetime] NOT NULL DEFAULT GETDATE(),
	[pr_updated] [datetime] NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED
(
	[pr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[customers](
	[cu_id] [int] IDENTITY(1,1) NOT NULL,
	[cu_name] [nvarchar](60) NOT NULL,
	[cu_code] [nvarchar](30) NOT NULL DEFAULT '',
	[cu_street] [nvarchar](60) NOT NULL DEFAULT '',
	[cu_city] [nvarchar](40) NOT NULL DEFAULT '',
	[cu_state] [nvarchar](40) NOT NULL DEFAULT '',
	[cu_zip] [nvarchar](20) NOT NULL DEFAULT '',
	[cu_country] [nvarchar](40) NOT NULL DEFAULT '',
	[cu_phone] [nvarchar](30) NOT NULL DEFAULT '',
	[cu_email] [nvarchar](100) NOT NULL DEFAULT '',
	[cu_contact] [nvarchar](60) NOT NULL DEFAULT '',
	[cu_active] [bit] NOT NULL DEFAULT 1,
	[cu_notes] [nvarchar](max) NOT NULL DEFAULT '',
	[cu_created] [datetime] NOT NULL DEFAULT GETDATE(),
 CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED
(
	[cu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[vendors](
	[ve_id] [int] IDENTITY(1,1) NOT NULL,
	[ve_name] [nvarchar](60) NOT NULL,
	[ve_code] [nvarchar](30) NOT NULL DEFAULT '',
	[ve_street] [nvarchar](60) NOT NULL DEFAULT '',
	[ve_city] [nvarchar](40) NOT NULL DEFAULT '',
	[ve_state] [nvarchar](40) NOT NULL DEFAULT '',
	[ve_zip] [nvarchar](20) NOT NULL DEFAULT '',
	[ve_phone] [nvarchar](30) NOT NULL DEFAULT '',
	[ve_contact] [nvarchar](60) NOT NULL DEFAULT '',
	[ve_active] [bit] NOT NULL DEFAULT 1,
	[ve_notes] [nvarchar](max) NOT NULL DEFAULT '',
 CONSTRAINT [PK_vendors] PRIMARY KEY CLUSTERED
(
	[ve_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[warehouses](
	[wa_id] [int] IDENTITY(1,1) NOT NULL,
	[wa_name] [nvarchar](60) NOT NULL,
	[wa_code] [nvarchar](20) NOT NULL DEFAULT '',
	[wa_street] [nvarchar](60) NOT NULL DEFAULT '',
	[wa_city] [nvarchar](40) NOT NULL DEFAULT '',
	[wa_state] [nvarchar](40) NOT NULL DEFAULT '',
	[wa_zip] [nvarchar](20) NOT NULL DEFAULT '',
	[wa_active] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_warehouses] PRIMARY KEY CLUSTERED
(
	[wa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[units_of_measure](
	[um_id] [int] IDENTITY(1,1) NOT NULL,
	[um_name] [nvarchar](30) NOT NULL,
	[um_abbrev] [nvarchar](10) NOT NULL DEFAULT '',
 CONSTRAINT [PK_units_of_measure] PRIMARY KEY CLUSTERED
(
	[um_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[orders](
	[or_id] [int] IDENTITY(1,1) NOT NULL,
	[or_number] [bigint] NOT NULL,
	[or_customer_id] [int] NOT NULL,
	[or_warehouse_id] [int] NOT NULL DEFAULT 1,
	[or_date] [datetime] NOT NULL DEFAULT GETDATE(),
	[or_status] [nvarchar](30) NOT NULL DEFAULT 'New',
	[or_total] [decimal](12, 2) NOT NULL DEFAULT 0,
	[or_notes] [nvarchar](max) NOT NULL DEFAULT '',
	[or_ship_date] [datetime] NULL,
	[or_created] [datetime] NOT NULL DEFAULT GETDATE(),
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED
(
	[or_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[order_lines](
	[ol_id] [int] IDENTITY(1,1) NOT NULL,
	[ol_order_id] [int] NOT NULL,
	[ol_product_id] [int] NOT NULL,
	[ol_qty] [int] NOT NULL DEFAULT 1,
	[ol_price] [decimal](12, 2) NOT NULL DEFAULT 0,
	[ol_total] [decimal](12, 2) NOT NULL DEFAULT 0,
	[ol_notes] [nvarchar](200) NOT NULL DEFAULT '',
 CONSTRAINT [PK_order_lines] PRIMARY KEY CLUSTERED
(
	[ol_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[inventory](
	[in_id] [int] IDENTITY(1,1) NOT NULL,
	[in_product_id] [int] NOT NULL,
	[in_warehouse_id] [int] NOT NULL,
	[in_lot] [nvarchar](50) NOT NULL DEFAULT '',
	[in_qty] [int] NOT NULL DEFAULT 0,
	[in_reserved] [int] NOT NULL DEFAULT 0,
	[in_expiry] [datetime] NULL,
	[in_received] [datetime] NOT NULL DEFAULT GETDATE(),
 CONSTRAINT [PK_inventory] PRIMARY KEY CLUSTERED
(
	[in_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


-- =============================================================================
-- WEBAPPMisc Database - Shared application tables
-- =============================================================================

USE [WEBAPPMisc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Reference table: Acid correction factors
CREATE TABLE [dbo].[AcidCorrection](
	[ac_id] [int] IDENTITY(1,1) NOT NULL,
	[PercentAcid] [float] NOT NULL,
	[AcidCorrection] [real] NULL,
 CONSTRAINT [PK_AcidCorrection] PRIMARY KEY CLUSTERED
(
	[ac_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Reference table: Brix chart data
CREATE TABLE [dbo].[BrixChart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[RefractiveIndex] [float] NULL,
	[Brix] [real] NOT NULL,
	[SpecificGravity] [float] NULL,
	[LbPerGallon] [float] NULL,
	[PoundSolid] [float] NULL,
 CONSTRAINT [PK_BrixChart] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Scheduler: Order headers shared by WAMS, InventoryPicking, AppointmentImport
CREATE TABLE [dbo].[webapp_scheduler](
	[gs_index] [int] IDENTITY(1,1) NOT NULL,
	[gs_id] [numeric](18, 0) NOT NULL,
	[gs_ordnum] [bigint] NOT NULL,
	[gs_dock] [nchar](10) NULL,
	[gs_datestart] [datetime] NULL,
	[gs_dateend] [datetime] NULL,
	[gs_dockm] [time](7) NULL,
	[gs_company] [nvarchar](50) NULL,
	[gs_carrier] [nvarchar](50) NULL,
	[gs_driver] [nvarchar](50) NULL,
	[gs_notes] [nvarchar](200) NULL,
	[gs_datechkin] [datetime] NULL,
	[gs_status] [nvarchar](50) NULL,
	[gs_appid] [nvarchar](50) NOT NULL,
	[gs_forkop] [nvarchar](max) NULL,
	[gs_chr1] [nvarchar](50) NULL,
	[gs_chr2] [nvarchar](50) NULL,
	[gs_chr3] [nvarchar](50) NULL,
	[gs_num1] [bigint] NULL,
	[gs_num2] [bigint] NULL,
	[gs_num3] [bigint] NULL,
	[gs_dec1] [decimal](18, 0) NULL,
	[gs_dec2] [decimal](18, 0) NULL,
	[gs_dec3] [decimal](18, 0) NULL,
	[gs_log1] [bit] NULL,
	[gs_log2] [bit] NULL,
	[gs_log3] [bit] NULL,
	[gs_img1] [image] NULL,
	[gs_img2] [image] NULL,
	[gs_img3] [image] NULL,
	[gs_date1] [datetime] NULL,
	[gs_date2] [datetime] NULL,
	[gs_date3] [datetime] NULL,
	[gs_picker] [nvarchar](50) NULL,
	[gs_pickerout] [datetime] NULL,
	[gs_pickerin] [datetime] NULL,
	[gs_auditor] [nvarchar](50) NULL,
	[gs_auditorout] [datetime] NULL,
	[gs_auditorin] [datetime] NULL,
	[gs_assembler] [nvarchar](50) NULL,
	[gs_assemblerout] [datetime] NULL,
	[gs_assemblerin] [datetime] NULL,
	[gs_chr4] [nvarchar](50) NULL,
	[gs_chr5] [nvarchar](50) NULL,
	[gs_chr6] [nvarchar](50) NULL,
	[gs_num4] [bigint] NULL,
	[gs_num5] [bigint] NULL,
	[gs_num6] [bigint] NULL,
	[gs_dec4] [decimal](18, 0) NULL,
	[gs_dec5] [decimal](18, 0) NULL,
	[gs_dec6] [bigint] NULL,
	[gs_log4] [bit] NULL,
	[gs_log5] [bit] NULL,
	[gs_log6] [bit] NULL,
	[gs_img4] [image] NULL,
	[gs_img5] [image] NULL,
	[gs_img6] [image] NULL,
	[gs_date4] [datetime] NULL,
	[gs_date5] [datetime] NULL,
	[gs_date6] [datetime] NULL,
	[gs_pronum] [int] NULL,
	[gs_pallets] [int] NULL,
	[gs_nwt] [decimal](18, 0) NULL,
	[gs_gwt] [decimal](18, 0) NULL,
	[gs_notesict] [nvarchar](max) NULL,
 CONSTRAINT [PK_webapp_scheduler] PRIMARY KEY CLUSTERED
(
	[gs_index] ASC,
	[gs_id] ASC,
	[gs_ordnum] ASC,
	[gs_appid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Allocations: Line items for InventoryAllocation and InventoryPicking
CREATE TABLE [dbo].[webapp_allocate](
	[all_index] [int] IDENTITY(1,1) NOT NULL,
	[all_id] [numeric](18, 0) NOT NULL,
	[all_ordernum] [bigint] NOT NULL,
	[all_codenum] [nvarchar](50) NOT NULL,
	[all_userlot] [nvarchar](50) NOT NULL,
	[all_qty] [int] NULL,
	[all_pick] [int] NULL,
	[all_date] [datetime] NULL,
	[all_chr1] [nvarchar](50) NULL,
	[all_chr2] [nvarchar](50) NULL,
	[all_chr3] [nvarchar](50) NULL,
	[all_chx1] [nvarchar](max) NULL,
	[all_chx2] [nvarchar](max) NULL,
	[all_chx3] [nvarchar](max) NULL,
	[all_int1] [int] NULL,
	[all_int2] [int] NULL,
	[all_int3] [int] NULL,
	[all_num1] [numeric](18, 0) NULL,
	[all_num2] [numeric](18, 0) NULL,
	[all_num3] [numeric](18, 0) NULL,
	[all_date1] [datetime] NULL,
	[all_date2] [datetime] NULL,
	[all_date3] [datetime] NULL,
	[all_dec1] [decimal](18, 8) NULL,
	[all_description] [nvarchar](50) NULL,
	[all_um] [nvarchar](50) NULL,
	[all_chr4] [nvarchar](50) NULL,
	[all_chr5] [nvarchar](50) NULL,
	[all_chr6] [nvarchar](50) NULL,
	[all_chx4] [nvarchar](max) NULL,
	[all_chx5] [nvarchar](max) NULL,
	[all_chx6] [nvarchar](max) NULL,
	[all_int4] [int] NULL,
	[all_int5] [int] NULL,
	[all_int6] [int] NULL,
	[all_dec4] [decimal](18, 0) NULL,
	[all_dec5] [decimal](18, 0) NULL,
	[all_dec6] [decimal](18, 0) NULL,
	[all_date4] [datetime] NULL,
	[all_date5] [datetime] NULL,
	[all_date6] [datetime] NULL,
	[all_dec3] [decimal](18, 0) NULL,
	[all_nwt] [decimal](18, 0) NULL,
	[all_gwt] [decimal](18, 0) NULL,
	[all_status] [nvarchar](50) NULL,
	[all_carrier] [nvarchar](50) NULL,
	[all_notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_webapp_allocate] PRIMARY KEY CLUSTERED
(
	[all_index] ASC,
	[all_id] ASC,
	[all_ordernum] ASC,
	[all_codenum] ASC,
	[all_userlot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Locks: Pessimistic locking for InventoryAllocation
CREATE TABLE [dbo].[webapp_lock](
	[gl_index] [int] IDENTITY(1,1) NOT NULL,
	[gl_id] [int] NOT NULL,
	[gl_ordnum] [bigint] NOT NULL,
	[gl_partnum] [nvarchar](50) NOT NULL,
	[gl_userlot] [nvarchar](50) NOT NULL,
	[gl_username] [nvarchar](50) NULL,
	[gl_qty1] [int] NULL,
	[gl_qty2] [int] NULL,
	[gl_qty3] [int] NULL,
	[gl_datel] [datetime] NULL,
	[gl_date1] [datetime] NULL,
	[gl_date2] [datetime] NULL,
	[gl_notes1] [nvarchar](max) NULL,
	[gl_notes2] [nvarchar](max) NULL,
	[gl_chr1] [nvarchar](50) NULL,
	[gl_chr2] [nvarchar](50) NULL,
	[gl_chx1] [nvarchar](max) NULL,
	[gl_chx2] [nvarchar](max) NULL,
	[gl_int1] [int] NULL,
	[gl_int2] [int] NULL,
	[gl_dec1] [decimal](18, 0) NULL,
	[gl_dec2] [decimal](18, 0) NULL,
	[gl_date3] [datetime] NULL,
	[gl_date4] [datetime] NULL,
 CONSTRAINT [PK_webapp_lock] PRIMARY KEY CLUSTERED
(
	[gl_index] ASC,
	[gl_id] ASC,
	[gl_ordnum] ASC,
	[gl_partnum] ASC,
	[gl_userlot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- User configuration: Warehouse assignments and user settings
CREATE TABLE [dbo].[webapp_dmstech](
	[gs_index] [int] IDENTITY(1,1) NOT NULL,
	[gs_id] [numeric](18, 0) NOT NULL,
	[gs_type] [int] NOT NULL,
	[gs_chr1] [nvarchar](50) NOT NULL,
	[gs_chr2] [nvarchar](50) NULL,
	[gs_chr3] [nvarchar](50) NULL,
	[gs_chr4] [nvarchar](50) NULL,
	[gs_chr5] [nvarchar](50) NULL,
	[gs_chx1] [nvarchar](max) NULL,
	[gs_chx2] [nvarchar](50) NULL,
	[gs_chx3] [nvarchar](50) NULL,
	[gs_int1] [int] NULL,
	[gs_int2] [int] NULL,
	[gs_int3] [int] NULL,
	[gs_date1] [datetime] NULL,
	[gs_date2] [datetime] NULL,
	[gs_date3] [datetime] NULL,
	[gs_consignor_sig] [varbinary](max) NULL,
	[gs_driver_sig] [varbinary](max) NULL,
	[gs_security2] [nvarchar](50) NULL,
 CONSTRAINT [PK_webapp_dmstech] PRIMARY KEY CLUSTERED
(
	[gs_index] ASC,
	[gs_id] ASC,
	[gs_type] ASC,
	[gs_chr1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

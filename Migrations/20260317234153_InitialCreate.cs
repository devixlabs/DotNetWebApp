using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DotNetWebApp.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "dbo");

            migrationBuilder.CreateTable(
                name: "acidcorrection",
                schema: "dbo",
                columns: table => new
                {
                    ac_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PercentAcid = table.Column<double>(type: "float", nullable: false),
                    AcidCorrection = table.Column<float>(type: "real", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_acidcorrection", x => x.ac_id);
                });

            migrationBuilder.CreateTable(
                name: "brixchart",
                schema: "dbo",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RefractiveIndex = table.Column<double>(type: "float", nullable: true),
                    Brix = table.Column<float>(type: "real", nullable: false),
                    SpecificGravity = table.Column<double>(type: "float", nullable: true),
                    LbPerGallon = table.Column<double>(type: "float", nullable: true),
                    PoundSolid = table.Column<double>(type: "float", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_brixchart", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "customers",
                schema: "dbo",
                columns: table => new
                {
                    cu_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    cu_name = table.Column<string>(type: "nvarchar(60)", maxLength: 60, nullable: false),
                    cu_code = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    cu_street = table.Column<string>(type: "nvarchar(60)", maxLength: 60, nullable: false),
                    cu_city = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: false),
                    cu_state = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: false),
                    cu_zip = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    cu_country = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: false),
                    cu_phone = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    cu_email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    cu_contact = table.Column<string>(type: "nvarchar(60)", maxLength: 60, nullable: false),
                    cu_active = table.Column<bool>(type: "bit", nullable: false),
                    cu_notes = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    cu_created = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_customers", x => x.cu_id);
                });

            migrationBuilder.CreateTable(
                name: "inventory",
                schema: "dbo",
                columns: table => new
                {
                    in_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    in_product_id = table.Column<int>(type: "int", nullable: false),
                    in_warehouse_id = table.Column<int>(type: "int", nullable: false),
                    in_lot = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    in_qty = table.Column<int>(type: "int", nullable: false),
                    in_reserved = table.Column<int>(type: "int", nullable: false),
                    in_expiry = table.Column<DateTime>(type: "datetime2", nullable: true),
                    in_received = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_inventory", x => x.in_id);
                });

            migrationBuilder.CreateTable(
                name: "order_lines",
                schema: "dbo",
                columns: table => new
                {
                    ol_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ol_order_id = table.Column<int>(type: "int", nullable: false),
                    ol_product_id = table.Column<int>(type: "int", nullable: false),
                    ol_qty = table.Column<int>(type: "int", nullable: false),
                    ol_price = table.Column<decimal>(type: "decimal(12,2)", nullable: false),
                    ol_total = table.Column<decimal>(type: "decimal(12,2)", nullable: false),
                    ol_notes = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_order_lines", x => x.ol_id);
                });

            migrationBuilder.CreateTable(
                name: "orders",
                schema: "dbo",
                columns: table => new
                {
                    or_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    or_number = table.Column<long>(type: "bigint", nullable: false),
                    or_customer_id = table.Column<int>(type: "int", nullable: false),
                    or_warehouse_id = table.Column<int>(type: "int", nullable: false),
                    or_date = table.Column<DateTime>(type: "datetime2", nullable: false),
                    or_status = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    or_total = table.Column<decimal>(type: "decimal(12,2)", nullable: false),
                    or_notes = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    or_ship_date = table.Column<DateTime>(type: "datetime2", nullable: true),
                    or_created = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_orders", x => x.or_id);
                });

            migrationBuilder.CreateTable(
                name: "products",
                schema: "dbo",
                columns: table => new
                {
                    pr_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    pr_name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    pr_code = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    pr_price = table.Column<decimal>(type: "decimal(12,2)", nullable: false),
                    pr_cost = table.Column<decimal>(type: "decimal(12,2)", nullable: false),
                    pr_category = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    pr_unit = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    pr_active = table.Column<bool>(type: "bit", nullable: false),
                    pr_notes = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    pr_created = table.Column<DateTime>(type: "datetime2", nullable: false),
                    pr_updated = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_products", x => x.pr_id);
                });

            migrationBuilder.CreateTable(
                name: "units_of_measure",
                schema: "dbo",
                columns: table => new
                {
                    um_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    um_name = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    um_abbrev = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_units_of_measure", x => x.um_id);
                });

            migrationBuilder.CreateTable(
                name: "vendors",
                schema: "dbo",
                columns: table => new
                {
                    ve_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ve_name = table.Column<string>(type: "nvarchar(60)", maxLength: 60, nullable: false),
                    ve_code = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    ve_street = table.Column<string>(type: "nvarchar(60)", maxLength: 60, nullable: false),
                    ve_city = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: false),
                    ve_state = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: false),
                    ve_zip = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    ve_phone = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    ve_contact = table.Column<string>(type: "nvarchar(60)", maxLength: 60, nullable: false),
                    ve_active = table.Column<bool>(type: "bit", nullable: false),
                    ve_notes = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_vendors", x => x.ve_id);
                });

            migrationBuilder.CreateTable(
                name: "warehouses",
                schema: "dbo",
                columns: table => new
                {
                    wa_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    wa_name = table.Column<string>(type: "nvarchar(60)", maxLength: 60, nullable: false),
                    wa_code = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    wa_street = table.Column<string>(type: "nvarchar(60)", maxLength: 60, nullable: false),
                    wa_city = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: false),
                    wa_state = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: false),
                    wa_zip = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    wa_active = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_warehouses", x => x.wa_id);
                });

            migrationBuilder.CreateTable(
                name: "webapp_allocate",
                schema: "dbo",
                columns: table => new
                {
                    all_index = table.Column<int>(type: "int", nullable: false),
                    all_id = table.Column<decimal>(type: "decimal(18,0)", nullable: false),
                    all_ordernum = table.Column<long>(type: "bigint", nullable: false),
                    all_codenum = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    all_userlot = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    all_qty = table.Column<int>(type: "int", nullable: true),
                    all_pick = table.Column<int>(type: "int", nullable: true),
                    all_date = table.Column<DateTime>(type: "datetime2", nullable: true),
                    all_chr1 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_chr2 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_chr3 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_chx1 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    all_chx2 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    all_chx3 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    all_int1 = table.Column<int>(type: "int", nullable: true),
                    all_int2 = table.Column<int>(type: "int", nullable: true),
                    all_int3 = table.Column<int>(type: "int", nullable: true),
                    all_num1 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    all_num2 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    all_num3 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    all_date1 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    all_date2 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    all_date3 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    all_dec1 = table.Column<decimal>(type: "decimal(18,8)", nullable: true),
                    all_description = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_um = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_chr4 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_chr5 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_chr6 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_chx4 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    all_chx5 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    all_chx6 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    all_int4 = table.Column<int>(type: "int", nullable: true),
                    all_int5 = table.Column<int>(type: "int", nullable: true),
                    all_int6 = table.Column<int>(type: "int", nullable: true),
                    all_dec4 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    all_dec5 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    all_dec6 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    all_date4 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    all_date5 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    all_date6 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    all_dec3 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    all_nwt = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    all_gwt = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    all_status = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_carrier = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    all_notes = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_webapp_allocate", x => new { x.all_index, x.all_id, x.all_ordernum, x.all_codenum, x.all_userlot });
                });

            migrationBuilder.CreateTable(
                name: "webapp_dmstech",
                schema: "dbo",
                columns: table => new
                {
                    gs_index = table.Column<int>(type: "int", nullable: false),
                    gs_id = table.Column<decimal>(type: "decimal(18,0)", nullable: false),
                    gs_type = table.Column<int>(type: "int", nullable: false),
                    gs_chr1 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    gs_chr2 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_chr3 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_chr4 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_chr5 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_chx1 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    gs_chx2 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_chx3 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_int1 = table.Column<int>(type: "int", nullable: true),
                    gs_int2 = table.Column<int>(type: "int", nullable: true),
                    gs_int3 = table.Column<int>(type: "int", nullable: true),
                    gs_date1 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_date2 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_date3 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_consignor_sig = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    gs_driver_sig = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    gs_security2 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_webapp_dmstech", x => new { x.gs_index, x.gs_id, x.gs_type, x.gs_chr1 });
                });

            migrationBuilder.CreateTable(
                name: "webapp_lock",
                schema: "dbo",
                columns: table => new
                {
                    gl_index = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    gl_id = table.Column<int>(type: "int", nullable: false),
                    gl_ordnum = table.Column<long>(type: "bigint", nullable: false),
                    gl_partnum = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    gl_userlot = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    gl_username = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gl_qty1 = table.Column<int>(type: "int", nullable: true),
                    gl_qty2 = table.Column<int>(type: "int", nullable: true),
                    gl_qty3 = table.Column<int>(type: "int", nullable: true),
                    gl_datel = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gl_date1 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gl_date2 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gl_notes1 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    gl_notes2 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    gl_chr1 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gl_chr2 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gl_chx1 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    gl_chx2 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    gl_int1 = table.Column<int>(type: "int", nullable: true),
                    gl_int2 = table.Column<int>(type: "int", nullable: true),
                    gl_dec1 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    gl_dec2 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    gl_date3 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gl_date4 = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_webapp_lock", x => new { x.gl_index, x.gl_id, x.gl_ordnum, x.gl_partnum, x.gl_userlot });
                });

            migrationBuilder.CreateTable(
                name: "webapp_scheduler",
                schema: "dbo",
                columns: table => new
                {
                    gs_index = table.Column<int>(type: "int", nullable: false),
                    gs_id = table.Column<decimal>(type: "decimal(18,0)", nullable: false),
                    gs_ordnum = table.Column<long>(type: "bigint", nullable: false),
                    gs_appid = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    gs_dock = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    gs_datestart = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_dateend = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_dockm = table.Column<TimeSpan>(type: "time", nullable: true),
                    gs_company = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_carrier = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_driver = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_notes = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    gs_datechkin = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_status = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_forkop = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    gs_chr1 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_chr2 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_chr3 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_num1 = table.Column<long>(type: "bigint", nullable: true),
                    gs_num2 = table.Column<long>(type: "bigint", nullable: true),
                    gs_num3 = table.Column<long>(type: "bigint", nullable: true),
                    gs_dec1 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    gs_dec2 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    gs_dec3 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    gs_log1 = table.Column<bool>(type: "bit", nullable: true),
                    gs_log2 = table.Column<bool>(type: "bit", nullable: true),
                    gs_log3 = table.Column<bool>(type: "bit", nullable: true),
                    gs_img1 = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    gs_img2 = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    gs_img3 = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    gs_date1 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_date2 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_date3 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_picker = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_pickerout = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_pickerin = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_auditor = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_auditorout = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_auditorin = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_assembler = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_assemblerout = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_assemblerin = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_chr4 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_chr5 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_chr6 = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    gs_num4 = table.Column<long>(type: "bigint", nullable: true),
                    gs_num5 = table.Column<long>(type: "bigint", nullable: true),
                    gs_num6 = table.Column<long>(type: "bigint", nullable: true),
                    gs_dec4 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    gs_dec5 = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    gs_dec6 = table.Column<long>(type: "bigint", nullable: true),
                    gs_log4 = table.Column<bool>(type: "bit", nullable: true),
                    gs_log5 = table.Column<bool>(type: "bit", nullable: true),
                    gs_log6 = table.Column<bool>(type: "bit", nullable: true),
                    gs_img4 = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    gs_img5 = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    gs_img6 = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    gs_date4 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_date5 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_date6 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gs_pronum = table.Column<int>(type: "int", nullable: true),
                    gs_pallets = table.Column<int>(type: "int", nullable: true),
                    gs_nwt = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    gs_gwt = table.Column<decimal>(type: "decimal(18,0)", nullable: true),
                    gs_notesict = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_webapp_scheduler", x => new { x.gs_index, x.gs_id, x.gs_ordnum, x.gs_appid });
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "acidcorrection",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "brixchart",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "customers",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "inventory",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "order_lines",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "orders",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "products",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "units_of_measure",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "vendors",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "warehouses",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "webapp_allocate",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "webapp_dmstech",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "webapp_lock",
                schema: "dbo");

            migrationBuilder.DropTable(
                name: "webapp_scheduler",
                schema: "dbo");
        }
    }
}

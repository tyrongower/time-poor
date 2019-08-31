using Microsoft.EntityFrameworkCore.Migrations;

namespace TimePoor.Api.Migrations
{
    public partial class setKeys : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TimeSheetEntry_Project_ProjectId",
                table: "TimeSheetEntry");

            migrationBuilder.AlterColumn<int>(
                name: "ProjectId",
                table: "TimeSheetEntry",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_TimeSheetEntry_Project_ProjectId",
                table: "TimeSheetEntry",
                column: "ProjectId",
                principalTable: "Project",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TimeSheetEntry_Project_ProjectId",
                table: "TimeSheetEntry");

            migrationBuilder.AlterColumn<int>(
                name: "ProjectId",
                table: "TimeSheetEntry",
                type: "int",
                nullable: true,
                oldClrType: typeof(int));

            migrationBuilder.AddForeignKey(
                name: "FK_TimeSheetEntry_Project_ProjectId",
                table: "TimeSheetEntry",
                column: "ProjectId",
                principalTable: "Project",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}

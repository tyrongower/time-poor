using Microsoft.EntityFrameworkCore.Migrations;

namespace TimePoor.Api.Migrations
{
    public partial class plural_naming : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TimeSheetEntry_Project_ProjectId",
                table: "TimeSheetEntry");

            migrationBuilder.DropPrimaryKey(
                name: "PK_TimeSheetEntry",
                table: "TimeSheetEntry");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Project",
                table: "Project");

            migrationBuilder.RenameTable(
                name: "TimeSheetEntry",
                newName: "TimeSheetEntries");

            migrationBuilder.RenameTable(
                name: "Project",
                newName: "Projects");

            migrationBuilder.RenameIndex(
                name: "IX_TimeSheetEntry_ProjectId",
                table: "TimeSheetEntries",
                newName: "IX_TimeSheetEntries_ProjectId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_TimeSheetEntries",
                table: "TimeSheetEntries",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Projects",
                table: "Projects",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_TimeSheetEntries_Projects_ProjectId",
                table: "TimeSheetEntries",
                column: "ProjectId",
                principalTable: "Projects",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TimeSheetEntries_Projects_ProjectId",
                table: "TimeSheetEntries");

            migrationBuilder.DropPrimaryKey(
                name: "PK_TimeSheetEntries",
                table: "TimeSheetEntries");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Projects",
                table: "Projects");

            migrationBuilder.RenameTable(
                name: "TimeSheetEntries",
                newName: "TimeSheetEntry");

            migrationBuilder.RenameTable(
                name: "Projects",
                newName: "Project");

            migrationBuilder.RenameIndex(
                name: "IX_TimeSheetEntries_ProjectId",
                table: "TimeSheetEntry",
                newName: "IX_TimeSheetEntry_ProjectId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_TimeSheetEntry",
                table: "TimeSheetEntry",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Project",
                table: "Project",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_TimeSheetEntry_Project_ProjectId",
                table: "TimeSheetEntry",
                column: "ProjectId",
                principalTable: "Project",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}

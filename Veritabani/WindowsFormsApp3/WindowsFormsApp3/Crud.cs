using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql;

namespace WindowsFormsApp3
{
    class Crud
    {
        public static void kitaplistele()
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5432; Database=baha; User Id=postgres; Password=zorsifre123;");
            conn.Open();
            string sql = "SELECT admin_adi FROM uye_admin";
            // Define a query returning a single row result set
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);

            NpgsqlDataReader dr = command.ExecuteReader();
            int count = 1;
            while (dr.Read())
            {
                Console.WriteLine(count + "-){0}\t{1}\n", dr[0], dr[1]);
                count++;

            }
            conn.Close();

        }
    }
}

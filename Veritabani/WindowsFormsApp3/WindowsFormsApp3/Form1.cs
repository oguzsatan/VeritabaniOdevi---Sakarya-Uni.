using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace WindowsFormsApp3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            MessageBox.Show("Ekleme butonuna basmadan önce Textboxu doldurmayı unutmayınız. Güncelleme yapmadan önce değiştirmek istediğiniz yeteneğin numarasını NumericUpDowna ve yeni ismini TextBoxun içine yazmayı unutmayınız. Silme işlemi yapmadan önce silmek istediğiniz yeteneğin numarasını NumericUpDownun içine yazmayı unutmayınız.");
        }
        public void temizle()
        {
            textBox2.Text = "";
            numericUpDown1.Value = 0;
        }
        public void yetenek_listele()
        {
            listBox1.Items.Clear();
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5432; Database=database1; User Id=postgres; Password=Oguz_1998;");
            conn.Open();
            string sql = "SELECT \"paketprobrambilgisi_id\",\"paketprorambilgisi_adi\" FROM \"paketprogrambilgisi_yeteneklerim\"";
            // Define a query returning a single row result set
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);

            NpgsqlDataReader dr = command.ExecuteReader();
            while (dr.Read())
            {
                listBox1.Items.Add(dr[0].ToString()+" "+dr[1].ToString());

            }
            conn.Close();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            yetenek_listele();
        }

        public void yetenek_ekle(string adi,int yuzde)
        {
            NpgsqlConnection connection = new NpgsqlConnection("Server=localhost; Port=5432; Database=database1; User Id=postgres; Password=Oguz_1998;");
            try { connection.Open(); } catch (Exception e) { }
            string date = "2010-10-10";
            string sql = "INSERT INTO paketprogrambilgisi_yeteneklerim (paketprorambilgisi_adi,paketprogrambilgisi_yuzde,kullanici_id,yetenek_tarih) values ('" + adi + "','" + yuzde + "','" + 1 + "','" + date  + "')";
            NpgsqlCommand cmd = new NpgsqlCommand(sql, connection);
            cmd.ExecuteNonQuery();
            connection.Close();
        }

        public void uyeligimiGuncelle(string adi, int no)
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5432; Database=database1; User Id=postgres; Password=Oguz_1998;");
            try { conn.Open(); } catch (Exception e) { }

            string sql = "UPDATE \"paketprogrambilgisi_yeteneklerim\" SET \"paketprorambilgisi_adi\"=\'" + adi + "\' WHERE \"paketprobrambilgisi_id\"=\'" + no + "\'";
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);
            command.ExecuteNonQuery();
            conn.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            yetenek_ekle(textBox2.Text,Convert.ToInt32(numericUpDown1.Value));
            temizle();
            yetenek_listele();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            uyeligimiGuncelle(textBox2.Text,Convert.ToInt32(numericUpDown1.Value));
            temizle();
            yetenek_listele();
        }
        public void yetenek_sil(int no)
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5432; Database=database1; User Id=postgres; Password=Oguz_1998;");
            try { conn.Open(); } catch (Exception e) { }

            string sql = "DELETE FROM paketprogrambilgisi_yeteneklerim WHERE paketprobrambilgisi_id='" + no + "'";
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);
            command.ExecuteNonQuery();
            conn.Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            yetenek_sil(Convert.ToInt32(numericUpDown1.Value));
            temizle();
            yetenek_listele();
        }
    }
}

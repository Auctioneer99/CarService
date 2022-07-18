namespace CarServiceBackend.GraphQL.Models.Report
{
    public class WorkReport
    {
        public double Price { get; set; }

        public int Count { get; set; }

        public WorkReport(double price, int count)
        {
            Price = price;
            Count = count;
        }
    }
}

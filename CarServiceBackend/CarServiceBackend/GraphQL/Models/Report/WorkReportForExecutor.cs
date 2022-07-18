namespace CarServiceBackend.GraphQL.Models.Report
{
    public class WorkReportForExecutor
    {
        public double Price { get; set; }

        public int Count { get; set; }

        public WorkReportForExecutor(double price, int count)
        {
            Price = price;
            Count = count;
        }
    }
}

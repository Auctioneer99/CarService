namespace CarServiceBackend.GraphQL.Models.Report
{
    public class WorkReportForTransport
    {
        public double Mileage { get; set; }

        public double Price { get; set; }

        public WorkReportForTransport(double price, double mileage)
        {
            Price = price;
            Mileage = mileage;
        }
    }
}

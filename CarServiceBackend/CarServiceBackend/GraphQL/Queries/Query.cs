using CarServiceBackend.Auth;
using CarServiceBackend.Database.Models;
using CarServiceBackend.Repository;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using CarServiceBackend.Database.Views;
using CarServiceBackend.GraphQL.Middleware;
using CarServiceBackend.GraphQL.Models.Report;

namespace CarServiceBackend.GraphQL.Queries
{
    public class Query
    {
        [MyAuthorize]
        [UsePaging(MaxPageSize = 20)]
        [UseFiltering]
        public IQueryable<Transport> GetTransports(
            [GraphQLName("number")] string? number,
            ClaimsPrincipal claimsPrincipal, 
            [Service] TransportRepository repository
            )
        {
            var query = repository.GetQuery();

            if (number != null)
            {
                query = query.Where(t => t.Number.ToLower().Contains(number.ToLower()));
            }

            if (claimsPrincipal.NotInRole(ERole.Executor | ERole.Admin))
            {
                return query.Where(t => t.OwnerId.Equals(claimsPrincipal.GetId()));
            }
            //if (claimsPrincipal.IsInRole(ERole.Executor))
            //{
            //    return query.Include(t => t.Works).Where(t => t.Works.Any(w => w.ExecutorId.Equals(claimsPrincipal.GetId())));
            //}
            return query;
        }

        [MyAuthorize]
        [UseOffsetPaging(MaxPageSize = 20, IncludeTotalCount = true)]
        [UseFiltering]
        public IQueryable<Work> GetWorks(
            ClaimsPrincipal claimsPrincipal, 
            [Service] WorkRepository repository
            )
        {
            var query = repository.GetQuery()
                    .Include(w => w.Transport)
                    .Include(w => w.Executor);

            if (claimsPrincipal.NotInRole(ERole.Executor | ERole.Admin))
            {
                return query.Where(w => w.Transport.OwnerId.Equals(claimsPrincipal.GetId()));
            }

            if (claimsPrincipal.IsInRole(ERole.Executor))
            {
                return query.Where(w => w.ExecutorId.Equals(claimsPrincipal.GetId()));
            }

            return query;
        }

        [MyAuthorize(ERole.Executor)]
        [UsePaging(MaxPageSize = 20)]
        [UseFiltering]
        public IQueryable<Userview> GetOwners(
            [GraphQLName("name")] string name,
            [Service] UserViewRepository userViewRepository
            )
        {
            return userViewRepository.GetQuery()
                .Where(u => u.Role.Equals("customer"))
                .Where(u => u.Name.ToLower().Contains(name.ToLower()));
        }

        [MyAuthorize(ERole.Admin)]
        [UsePaging(MaxPageSize = 20)]
        [UseFiltering]
        public IQueryable<Userview> GetUsers(
            [GraphQLName("name")] string name,
            [Service] UserViewRepository userViewRepository
            )
        {
            return userViewRepository.GetQuery().Where(u => u.Name.ToLower().Contains(name.ToLower()));
        }

        [MyAuthorize(ERole.Admin | ERole.Customer)]
        public WorkReportForTransport GetWorkReportForTransport(
            [GraphQLName("id")] long transportId,
            [GraphQLName("dateFrom")] DateTime from,
            [GraphQLName("dateTo")] DateTime to,
            ClaimsPrincipal claimsPrincipal,
            [Service] WorkRepository repository
            )
        {
            var query = repository.GetQuery().Where(w => w.TransportId.Equals(transportId));
            if (claimsPrincipal.NotInRole(ERole.Admin))
            {
                query = query
                    .Include(w => w.Transport)
                    .Where(w => w.Transport.OwnerId.Equals(claimsPrincipal.GetId()));
            }

            return query
                .Where(w => w.PerformDate >= from)
                .Where(w => w.PerformDate <= to)
                .GroupBy(w => w.TransportId)
                .Select(g => new WorkReportForTransport(g.Sum(w => w.Price), g.Sum(w => w.Mileage)))
                .FirstOrDefault() ?? new WorkReportForTransport(0, 0);
        }

        [MyAuthorize(ERole.Admin | ERole.Executor)]
        public WorkReport GetWorkReport(
            [GraphQLName("dateFrom")] DateTime from,
            [GraphQLName("dateTo")] DateTime to,
            ClaimsPrincipal claimsPrincipal,
            [Service] WorkRepository repository
            )
        {
            var query = repository.GetQuery();
            if (claimsPrincipal.IsInRole(ERole.Executor))
            {
                query = query.Where(w => w.ExecutorId.Equals(claimsPrincipal.GetId()));
            }

            return query
                .Where(w => w.PerformDate >= from)
                .Where(w => w.PerformDate <= to)
                .GroupBy(w => true)
                .Select(g => new WorkReport(g.Sum(w => w.Price), g.Count()))
                .FirstOrDefault() ?? new WorkReport(0, 0);
        }

        [MyAuthorize(ERole.Admin)]
        public WorkReportForCustomer GetWorkReportForCustomer(
            [GraphQLName("id")] string customerId,
            [GraphQLName("dateFrom")] DateTime from,
            [GraphQLName("dateTo")] DateTime to,
            [Service] WorkRepository repository
            )
        {
            return repository.GetQuery()
                .Include(w => w.Transport)
                .Where(w => w.Transport.OwnerId.Equals(customerId))
                .Where(w => w.PerformDate >= from)
                .Where(w => w.PerformDate <= to)
                .GroupBy(w => w.Transport.OwnerId)
                .Select(g => new WorkReportForCustomer(g.Sum(w => w.Price), g.Count()))
                .FirstOrDefault() ?? new WorkReportForCustomer(0, 0);
        }

        [MyAuthorize(ERole.Admin)]
        public WorkReportForExecutor GetWorkReportForExecutor(
            [GraphQLName("id")] string executorId,
            [GraphQLName("dateFrom")] DateTime from,
            [GraphQLName("dateTo")] DateTime to,
            [Service] WorkRepository repository
            )
        {
            return repository.GetQuery()
                .Where(w => w.ExecutorId.Equals(executorId))
                .Where(w => w.PerformDate >= from)
                .Where(w => w.PerformDate <= to)
                .GroupBy(w => w.ExecutorId)
                .Select(g => new WorkReportForExecutor(g.Sum(w => w.Price), g.Count()))
                .FirstOrDefault() ?? new WorkReportForExecutor(0, 0);
        }
    }
}

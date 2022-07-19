using AutoMapper;
using CarServiceBackend.Auth;
using CarServiceBackend.Database.Models;
using CarServiceBackend.GraphQL.Models;
using CarServiceBackend.GraphQL.Models.Transport;
using CarServiceBackend.GraphQL.Models.Work;
using CarServiceBackend.Repository;
using System.Security.Claims;

namespace CarServiceBackend.GraphQL.Queries.Executor
{
    public class ExecutorMutation
    {
        [Error(typeof(InvalidEntityException))]
        public async Task<Work> AddWork(
            [GraphQLName("input")] WorkAddView toAdd,
            ClaimsPrincipal claimsPrincipal,
            [Service] TransportRepository transportRepository,
            [Service] WorkRepository workRepository,
            [Service] IMapper mapper
            )
        {
            var mapped = mapper.Map<Work>(toAdd);
            mapped.ExecutorId = claimsPrincipal.GetId();

            var transport = transportRepository.GetQuery()
                .Where(t => t.Id.Equals(mapped.TransportId))
                .FirstOrDefault();
            if (transport == null)
            {
                throw new InvalidEntityException("Транспорт");
            }

            mapped.Transport = transport;
            return await workRepository.Add(mapped);
        }

        [Error(typeof(InvalidEntityException))]
        public async Task<Work> UpdateWork(
            [GraphQLName("input")] WorkUpdateView toUpdate,
            ClaimsPrincipal claimsPrincipal,
            [Service] WorkRepository workRepository
            )
        {
            var work = workRepository.GetQuery().Where(w => w.Id.Equals(toUpdate.Id)).FirstOrDefault();
            if (work == null)
            {
                throw new InvalidEntityException("Id");
            }
            if (toUpdate.ReturnDate != null)
            {
                var d = toUpdate.ReturnDate.Value.ToUniversalTime();
                var d2 = work.PerformDate.ToUniversalTime();
                if (d < d2)
                {
                    throw new InvalidEntityException("Дата возврата");
                }
            }
            if (work.ExecutorId != claimsPrincipal.GetId())
            {
                throw new UnauthorizedAccessException("Заказ не зарегестрирован за исполнителем");
            }

            work.ReturnDate = toUpdate.ReturnDate;
            work.Mileage = toUpdate.Mileage;
            work.Price = toUpdate.Price;
            work.Task = toUpdate.Task;

            return await workRepository.Update(work);
        }

        [Error(typeof(InvalidEntityException))]
        public async Task<Transport> AddTransport(
            [GraphQLName("input")] TransportAddView toAdd,
            [Service] TransportRepository transportRepository,
            [Service] UserViewRepository userViewRepository,
            [Service] IMapper mapper
            )
        {
            var mapped = mapper.Map<Transport>(toAdd);
            var user = userViewRepository.GetQuery()
                .Where(u => u.Id.Equals(mapped.OwnerId) && u.Role.Equals(RoleStrings.CUSTOMER))
                .Any();
            if (user == false)
            {
                throw new InvalidEntityException("Владелец");
            }
            var alreadyExist = transportRepository.GetQuery().Where(t => t.Number.Equals(toAdd.Number)).Any();
            if (alreadyExist)
            {
                throw new InvalidEntityException("Номер");
            }

            return await transportRepository.Add(mapped);
        }
    }
}

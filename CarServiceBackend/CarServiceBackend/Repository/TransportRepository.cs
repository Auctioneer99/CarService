using AutoMapper.QueryableExtensions;
using CarServiceBackend.Database;
using CarServiceBackend.Database.Models;
using Microsoft.EntityFrameworkCore;

namespace CarServiceBackend.Repository
{
    public class TransportRepository
    {
        private readonly CarServiceContext _carContext;
        private readonly AutoMapper.IConfigurationProvider _mapperConfig;

        public TransportRepository(CarServiceContext carContext, AutoMapper.IConfigurationProvider mapperConfig)
        {
            _carContext = carContext;
            _mapperConfig = mapperConfig;
        }

        public async Task<Transport> Add(Transport transport)
        {
            _carContext.Transports.Add(transport);
            await _carContext.SaveChangesAsync();
            return transport;
        }

        public async Task<List<T>> GetAll<T>()
        {
            return await _carContext
                .Transports
                .ProjectTo<T>(_mapperConfig)
                .ToListAsync();
        }

        public async Task<IEnumerable<Transport>> GetAll()
        {
            return await _carContext
                .Transports
                .ToListAsync();
        }

        public IQueryable<Transport> GetQuery()
        {
            return _carContext.Transports;
        }
    }
}

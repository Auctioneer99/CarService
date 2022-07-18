using AutoMapper.QueryableExtensions;
using CarServiceBackend.Database;
using CarServiceBackend.Database.Views;
using Microsoft.EntityFrameworkCore;

namespace CarServiceBackend.Repository
{
    public class UserViewRepository
    {
        private readonly CarServiceContext _carContext;
        private readonly AutoMapper.IConfigurationProvider _mapperConfig;

        public UserViewRepository(CarServiceContext carContext, AutoMapper.IConfigurationProvider mapperConfig)
        {
            _carContext = carContext;
            _mapperConfig = mapperConfig;
        }

        public async Task<List<T>> GetAll<T>()
        {
            return await _carContext
                .Userviews
                .ProjectTo<T>(_mapperConfig)
                .ToListAsync();
        }

        public async Task<IEnumerable<Userview>> GetAll()
        {
            return await _carContext
                .Userviews
                .ToListAsync();
        }

        public IQueryable<Userview> GetQuery()
        {
            return _carContext.Userviews;
        }
    }
}

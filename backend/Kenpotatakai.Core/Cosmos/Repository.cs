using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;

namespace Kenpotatakai.Core.Cosmos
{
    public abstract class Repository<TEntity> : IRepository<TEntity>
    {
        private static string DatabaseId = "Kenpotatakai";
        private readonly string _collectionName;
        protected IDocumentClient DocumentClient;
        protected Uri DatabaseUri { get; }
        protected Uri CollectionUri { get; }

        protected Repository(IDocumentClient documentClient, string collectioName)
        {
            DocumentClient = documentClient;
            _collectionName = collectioName;

            DatabaseUri = UriFactory.CreateDatabaseUri(DatabaseId);
            CollectionUri = UriFactory.CreateDocumentCollectionUri(DatabaseId, _collectionName);
        }

        public async Task EnsureCollectionExists()
        {
            await DocumentClient.CreateDocumentCollectionIfNotExistsAsync(DatabaseUri, new DocumentCollection
            {
                Id = _collectionName
            });
        }

        public async Task<ResourceResponse<Document>> Create(TEntity entity)
        {
            return await DocumentClient.CreateDocumentAsync(CollectionUri, entity, new RequestOptions());
        }
    }
}

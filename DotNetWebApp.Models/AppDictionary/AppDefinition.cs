using YamlDotNet.Serialization;

#nullable disable

namespace DotNetWebApp.Models.AppDictionary
{
    public class AppDefinition
    {
        public AppMetadata App { get; set; }
        public Theme Theme { get; set; }
        public DataModel DataModel { get; set; }
    }

    public class AppMetadata
    {
        public string Name { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string LogoUrl { get; set; }
    }

    public class Theme
    {
        public string PrimaryColor { get; set; }
        public string SecondaryColor { get; set; }
        public string BackgroundColor { get; set; }
        public string TextColor { get; set; }
    }

    public class DataModel
    {
        public List<Entity> Entities { get; set; }
    }

    public class Entity
    {
        public string Name { get; set; }
        public string Schema { get; set; } = string.Empty;
        public List<Property> Properties { get; set; }
        public List<Relationship> Relationships { get; set; }
    }

    public class Property
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public bool IsPrimaryKey { get; set; }
        public bool IsIdentity { get; set; }
        public int? MaxLength { get; set; }
        public bool IsRequired { get; set; }
        public int? Precision { get; set; }
        public int? Scale { get; set; }
        public string DefaultValue { get; set; }
    }

    public class Relationship
    {
        public string Type { get; set; }
        public string TargetEntity { get; set; }
        public string ForeignKey { get; set; }
        public string PrincipalKey { get; set; }
    }
}